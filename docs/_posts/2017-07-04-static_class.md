---
layout: post
title:  "Using constants from a java final class, in jruby"
date:   2017-07-03 07:34:13
categories: pconstants update
---
Somewhat inspired by [ruby koans](http://rubykoans.com/) I believe the only way you will really get to get deep understanding of [JRubyArt][jruby_art] and [propane][propane] is by understanding the internals. Here we compile `PConstants.java` into a library and access the constants from ruby. We use minitest to explore the constants see [github][distro].

### Requirements

Requires JRuby, maven

### The Tests

```ruby
# frozen_string_literal: true
require 'java'
require_relative 'test_helper'
require_relative '../lib/pconstants'

module Constants
  java_import 'processing.core.PConstants'
  PConstants
end

class SpecTest < Minitest::Test
  include Constants

  def test_constants_is_a_module
    assert_equal Module, Constants.class, 'Constants not recognized as a module'
  end

  def test_p3d
    assert_equal String, PConstants::P3D.class, "failed #{:P3D} is a string"
    assert_equal Java::JavaLang::String, PConstants::P3D.to_java(:string).class, "failed #{:P3D} can be cast as a java string"
    assert_equal 'processing.opengl.PGraphics3D', PConstants::P3D, "failed #{:P3D} lookup"
  end

  def test_numeric
    assert_equal 8, PConstants::TRIANGLE, "failed #{:TRIANGLE} lookup"
    assert_in_delta 3.14159, PConstants::PI, 0.0001, "failed #{:PI} lookup"
  end
end
```

### The java final class

```java
/* -*- mode: java; c-basic-offset: 4; indent-tabs-mode: nil -*- */

 /*
  A controversial final class is preferred over using an interface for global
  constants. Use of enums is preferred for global access, however general
  recommendation is to include constants in classes that use them.
 */
package processing.core;

import java.awt.Cursor;
import java.awt.event.KeyEvent;

/**
 * Numbers shared throughout processing.core.
 * <P>
 * An attempt is made to keep the constants as short/non-verbose as possible.
 * For instance, the constant is TIFF instead of FILE_TYPE_TIFF. We'll do this
 * as long as we can get away with it.
 *
 * @usage Web &amp; Application
 */
public final class PConstants {

    private PConstants() {
    } // avoids instantiation

    public final static int X = 0;
    public final static int Y = 1;
    public final static int Z = 2;

    // renderers known to processing.core

    /*
  // List of renderers used inside PdePreprocessor
  public final static StringList rendererList = new StringList(new String[] {
    "JAVA2D", "JAVA2D_2X",
    "P2D", "P2D_2X", "P3D", "P3D_2X", "OPENGL",
    "E2D", "FX2D", "FX2D_2X",  // experimental
    "LWJGL.P2D", "LWJGL.P3D",  // hmm
    "PDF"  // no DXF because that's only for beginRaw()
  });
     */
    public final static String JAVA2D = "processing.awt.PGraphicsJava2D";

    public final static String P2D = "processing.opengl.PGraphics2D";
    public final static String P3D = "processing.opengl.PGraphics3D";

    // When will it be time to remove this?
    @Deprecated
    public final static String OPENGL = P3D;

    // Experimental, higher-performance Java 2D renderer (but no pixel ops)
//  public final static String E2D = PGraphicsDanger2D.class.getName();
    // Experimental JavaFX renderer; even better 2D performance
    public final static String FX2D = "processing.javafx.PGraphicsFX2D";

    public final static String PDF = "processing.pdf.PGraphicsPDF";
    public final static String SVG = "processing.svg.PGraphicsSVG";
    public final static String DXF = "processing.dxf.RawDXF";

    // platform IDs for PApplet.platform
    public final static int OTHER = 0;
    public final static int WINDOWS = 1;
    public final static int MACOSX = 2;
    public final static int LINUX = 3;

    public final static String[] platformNames = { // should use PLATFORM_NAMES
        "other", "windows", "macosx", "linux"
    };

    public final static float EPSILON = 0.0001f;

    // max/min values for numbers
    /**
     * Same as Float.MAX_VALUE, but included for parity with MIN_VALUE, and to
     * avoid teaching static methods on the first day.
     */
    public final static float MAX_FLOAT = Float.MAX_VALUE;
    /**
     * Note that Float.MIN_VALUE is the smallest <EM>positive</EM> value for a
     * floating point number, not actually the minimum (negative) value for a
     * float. This constant equals 0xFF7FFFFF, the smallest (farthest negative)
     * value a float can have before it hits NaN.
     */
    public final static float MIN_FLOAT = -Float.MAX_VALUE;
    /**
     * Largest possible (positive) integer value
     */
    public final static int MAX_INT = Integer.MAX_VALUE;
    /**
     * Smallest possible (negative) integer value
     */
    public final static int MIN_INT = Integer.MIN_VALUE;

    // shapes
    public final static int VERTEX = 0;
    public final static int BEZIER_VERTEX = 1;
    public final static int QUADRATIC_VERTEX = 2;
    public final static int CURVE_VERTEX = 3;
    public final static int BREAK = 4;

    @Deprecated
    public final static int QUAD_BEZIER_VERTEX = 2;  // should not have been exposed

    // useful goodness
    /**
     * ( begin auto-generated from PI.xml )
     *
     * PI is a mathematical constant with the value 3.14159265358979323846. It
     * is the ratio of the circumference of a circle to its diameter. It is
     * useful in combination with the trigonometric functions <b>sin()</b> and
     * <b>cos()</b>.
     *
     * ( end auto-generated )
     *
     * @webref constants
     * @see PConstants#TWO_PI
     * @see PConstants#TAU
     * @see PConstants#HALF_PI
     * @see PConstants#QUARTER_PI
     *
     */
    public final static float PI = (float) Math.PI;
    /**
     * ( begin auto-generated from HALF_PI.xml )
     *
     * HALF_PI is a mathematical constant with the value 1.57079632679489661923.
     * It is half the ratio of the circumference of a circle to its diameter. It
     * is useful in combination with the trigonometric functions <b>sin()</b>
     * and <b>cos()</b>.
     *
     * ( end auto-generated )
     *
     * @webref constants
     * @see PConstants#PI
     * @see PConstants#TWO_PI
     * @see PConstants#TAU
     * @see PConstants#QUARTER_PI
     */
    public final static float HALF_PI = (float) (Math.PI / 2.0);
    public final static float THIRD_PI = (float) (Math.PI / 3.0);
    /**
     * ( begin auto-generated from QUARTER_PI.xml )
     *
     * QUARTER_PI is a mathematical constant with the value 0.7853982. It is one
     * quarter the ratio of the circumference of a circle to its diameter. It is
     * useful in combination with the trigonometric functions
     * <b>sin()</b> and <b>cos()</b>.
     *
     * ( end auto-generated )
     *
     * @webref constants
     * @see PConstants#PI
     * @see PConstants#TWO_PI
     * @see PConstants#TAU
     * @see PConstants#HALF_PI
     */
    public final static float QUARTER_PI = (float) (Math.PI / 4.0);
    /**
     * ( begin auto-generated from TWO_PI.xml )
     *
     * TWO_PI is a mathematical constant with the value 6.28318530717958647693.
     * It is twice the ratio of the circumference of a circle to its diameter.
     * It is useful in combination with the trigonometric functions
     * <b>sin()</b> and <b>cos()</b>.
     *
     * ( end auto-generated )
     *
     * @webref constants
     * @see PConstants#PI
     * @see PConstants#TAU
     * @see PConstants#HALF_PI
     * @see PConstants#QUARTER_PI
     */
    public final static float TWO_PI = (float) (2.0 * Math.PI);
    /**
     * ( begin auto-generated from TAU.xml )
     *
     * TAU is an alias for TWO_PI, a mathematical constant with the value
     * 6.28318530717958647693. It is twice the ratio of the circumference of a
     * circle to its diameter. It is useful in combination with the
     * trigonometric functions <b>sin()</b> and <b>cos()</b>.
     *
     * ( end auto-generated )
     *
     * @webref constants
     * @see PConstants#PI
     * @see PConstants#TWO_PI
     * @see PConstants#HALF_PI
     * @see PConstants#QUARTER_PI
     */
    public final static float TAU = (float) (2.0 * Math.PI);

    public final static float DEG_TO_RAD = PI / 180.0f;
    public final static float RAD_TO_DEG = 180.0f / PI;

    // angle modes
    //public final static int RADIANS = 0;
    //public final static int DEGREES = 1;
    // used by split, all the standard whitespace chars
    // (also includes unicode nbsp, that little bostage)
    public final static String WHITESPACE = " \t\n\r\f\u00A0";

    // for colors and/or images
    public final static int RGB = 1;  // image & color
    public final static int ARGB = 2;  // image
    public final static int HSB = 3;  // color
    public final static int ALPHA = 4;  // image
//  public final static int CMYK  = 5;  // image & color (someday)

    // image file types
    public final static int TIFF = 0;
    public final static int TARGA = 1;
    public final static int JPEG = 2;
    public final static int GIF = 3;

    // filter/convert types
    public final static int BLUR = 11;
    public final static int GRAY = 12;
    public final static int INVERT = 13;
    public final static int OPAQUE = 14;
    public final static int POSTERIZE = 15;
    public final static int THRESHOLD = 16;
    public final static int ERODE = 17;
    public final static int DILATE = 18;

    // blend mode keyword definitions
    // @see processing.core.PImage#blendColor(int,int,int)
    public final static int REPLACE = 0;
    public final static int BLEND = 1; // 1 << 0;
    public final static int ADD = 1 << 1;
    public final static int SUBTRACT = 1 << 2;
    public final static int LIGHTEST = 1 << 3;
    public final static int DARKEST = 1 << 4;
    public final static int DIFFERENCE = 1 << 5;
    public final static int EXCLUSION = 1 << 6;
    public final static int MULTIPLY = 1 << 7;
    public final static int SCREEN = 1 << 8;
    public final static int OVERLAY = 1 << 9;
    public final static int HARD_LIGHT = 1 << 10;
    public final static int SOFT_LIGHT = 1 << 11;
    public final static int DODGE = 1 << 12;
    public final static int BURN = 1 << 13;

    // for messages
    public final static int CHATTER = 0;
    public final static int COMPLAINT = 1;
    public final static int PROBLEM = 2;

    // types of transformation matrices
    public final static int PROJECTION = 0;
    public final static int MODELVIEW = 1;

    // types of projection matrices
    public final static int CUSTOM = 0; // user-specified fanciness
    public final static int ORTHOGRAPHIC = 2; // 2D isometric projection
    public final static int PERSPECTIVE = 3; // perspective matrix

    // shapes
    // the low four bits set the variety,
    // higher bits set the specific shape type
    public final static int GROUP = 0;   // createShape()

    public final static int POINT = 2;   // primitive
    public final static int POINTS = 3;   // vertices

    public final static int LINE = 4;   // primitive
    public final static int LINES = 5;   // beginShape(), createShape()
    public final static int LINE_STRIP = 50;  // beginShape()
    public final static int LINE_LOOP = 51;

    public final static int TRIANGLE = 8;   // primitive
    public final static int TRIANGLES = 9;   // vertices
    public final static int TRIANGLE_STRIP = 10;  // vertices
    public final static int TRIANGLE_FAN = 11;  // vertices

    public final static int QUAD = 16;  // primitive
    public final static int QUADS = 17;  // vertices
    public final static int QUAD_STRIP = 18;  // vertices

    public final static int POLYGON = 20;  // in the end, probably cannot
    public final static int PATH = 21;  // separate these two

    public final static int RECT = 30;  // primitive
    public final static int ELLIPSE = 31;  // primitive
    public final static int ARC = 32;  // primitive

    public final static int SPHERE = 40;  // primitive
    public final static int BOX = 41;  // primitive

//  public final static int POINT_SPRITES = 52;
//  public final static int NON_STROKED_SHAPE = 60;
//  public final static int STROKED_SHAPE     = 61;
    // shape closing modes
    public final static int OPEN = 1;
    public final static int CLOSE = 2;

    // shape drawing modes
    /**
     * Draw mode convention to use (x, y) to (width, height)
     */
    public final static int CORNER = 0;
    /**
     * Draw mode convention to use (x1, y1) to (x2, y2) coordinates
     */
    public final static int CORNERS = 1;
    /**
     * Draw mode from the center, and using the radius
     */
    public final static int RADIUS = 2;
    /**
     * Draw from the center, using second pair of values as the diameter.
     * Formerly called CENTER_DIAMETER in alpha releases.
     */
    public final static int CENTER = 3;
    /**
     * Synonym for the CENTER constant. Draw from the center, using second pair
     * of values as the diameter.
     */
    public final static int DIAMETER = 3;

    // arc drawing modes
    //public final static int OPEN = 1;  // shared
    public final static int CHORD = 2;
    public final static int PIE = 3;

    // vertically alignment modes for text
    /**
     * Default vertical alignment for text placement
     */
    public final static int BASELINE = 0;
    /**
     * Align text to the top
     */
    public final static int TOP = 101;
    /**
     * Align text from the bottom, using the baseline.
     */
    public final static int BOTTOM = 102;

    // uv texture orientation modes
    /**
     * texture coordinates in 0..1 range
     */
    public final static int NORMAL = 1;
    /**
     * texture coordinates based on image width/height
     */
    public final static int IMAGE = 2;

    // texture wrapping modes
    /**
     * textures are clamped to their edges
     */
    public final static int CLAMP = 0;
    /**
     * textures wrap around when uv values go outside 0..1 range
     */
    public final static int REPEAT = 1;

    // text placement modes
    /**
     * textMode(MODEL) is the default, meaning that characters will be affected
     * by transformations like any other shapes.
     * <p/>
     * Changed value in 0093 to not interfere with LEFT, CENTER, and RIGHT.
     */
    public final static int MODEL = 4;

    /**
     * textMode(SHAPE) draws text using the the glyph outlines of individual
     * characters rather than as textures. If the outlines are not available,
     * then textMode(SHAPE) will be ignored and textMode(MODEL) will be used
     * instead. For this reason, be sure to call textMode()
     * <EM>after</EM> calling textFont().
     * <p/>
     * Currently, textMode(SHAPE) is only supported by OPENGL mode. It also
     * requires Java 1.2 or higher (OPENGL requires 1.4 anyway)
     */
    public final static int SHAPE = 5;

    // text alignment modes
    // are inherited from LEFT, CENTER, RIGHT
    // stroke modes
    public final static int SQUARE = 1; // 1 << 0;  // called 'butt' in the svg spec
    public final static int ROUND = 1 << 1;
    public final static int PROJECT = 1 << 2;  // called 'square' in the svg spec
    public final static int MITER = 1 << 3;
    public final static int BEVEL = 1 << 5;

    // lighting
    public final static int AMBIENT = 0;
    public final static int DIRECTIONAL = 1;
    //public final static int POINT  = 2;  // shared with shape feature
    public final static int SPOT = 3;

    // key constants
    // only including the most-used of these guys
    // if people need more esoteric keys, they can learn about
    // the esoteric java KeyEvent api and of virtual keys
    // both key and keyCode will equal these values
    // for 0125, these were changed to 'char' values, because they
    // can be upgraded to ints automatically by Java, but having them
    // as ints prevented split(blah, TAB) from working
    public final static char BACKSPACE = 8;
    public final static char TAB = 9;
    public final static char ENTER = 10;
    public final static char RETURN = 13;
    public final static char ESC = 27;
    public final static char DELETE = 127;

    // i.e. if ((key == CODED) && (keyCode == UP))
    public final static int CODED = 0xffff;

    // key will be CODED and keyCode will be this value
    public final static int UP = KeyEvent.VK_UP;
    public final static int DOWN = KeyEvent.VK_DOWN;
    public final static int LEFT = KeyEvent.VK_LEFT;
    public final static int RIGHT = KeyEvent.VK_RIGHT;

    // key will be CODED and keyCode will be this value
    public final static int ALT = KeyEvent.VK_ALT;
    public final static int CONTROL = KeyEvent.VK_CONTROL;
    public final static int SHIFT = KeyEvent.VK_SHIFT;

    // orientations (only used on Android, ignored on desktop)
    /**
     * Screen orientation constant for portrait (the hamburger way).
     */
    public final static int PORTRAIT = 1;
    /**
     * Screen orientation constant for landscape (the hot dog way).
     */
    public final static int LANDSCAPE = 2;

    /**
     * Use with fullScreen() to indicate all available displays.
     */
    public final static int SPAN = 0;

    // cursor types
    public final static int ARROW = Cursor.DEFAULT_CURSOR;
    public final static int CROSS = Cursor.CROSSHAIR_CURSOR;
    public final static int HAND = Cursor.HAND_CURSOR;
    public final static int MOVE = Cursor.MOVE_CURSOR;
    public final static int TEXT = Cursor.TEXT_CURSOR;
    public final static int WAIT = Cursor.WAIT_CURSOR;

    // hints - hint values are positive for the alternate version,
    // negative of the same value returns to the normal/default state
    @Deprecated
    public final static int ENABLE_NATIVE_FONTS = 1;
    @Deprecated
    public final static int DISABLE_NATIVE_FONTS = -1;

    public final static int DISABLE_DEPTH_TEST = 2;
    public final static int ENABLE_DEPTH_TEST = -2;

    public final static int ENABLE_DEPTH_SORT = 3;
    public final static int DISABLE_DEPTH_SORT = -3;

    public final static int DISABLE_OPENGL_ERRORS = 4;
    public final static int ENABLE_OPENGL_ERRORS = -4;

    public final static int DISABLE_DEPTH_MASK = 5;
    public final static int ENABLE_DEPTH_MASK = -5;

    public final static int DISABLE_OPTIMIZED_STROKE = 6;
    public final static int ENABLE_OPTIMIZED_STROKE = -6;

    public final static int ENABLE_STROKE_PERSPECTIVE = 7;
    public final static int DISABLE_STROKE_PERSPECTIVE = -7;

    public final static int DISABLE_TEXTURE_MIPMAPS = 8;
    public final static int ENABLE_TEXTURE_MIPMAPS = -8;

    public final static int ENABLE_STROKE_PURE = 9;
    public final static int DISABLE_STROKE_PURE = -9;

    public final static int ENABLE_BUFFER_READING = 10;
    public final static int DISABLE_BUFFER_READING = -10;

    public final static int DISABLE_KEY_REPEAT = 11;
    public final static int ENABLE_KEY_REPEAT = -11;

    public final static int DISABLE_ASYNC_SAVEFRAME = 12;
    public final static int ENABLE_ASYNC_SAVEFRAME = -12;

    public final static int HINT_COUNT = 13;
}

```

[distro]:https://github.com/ruby-processing/PConstants
[jruby_art]:https://github.com/ruby-processing/JRubyArt
[propane]:https://github.com/ruby-processing/propane
