---
layout: post
title:  "Using constant_missing, to access java enum in jruby"
date:   2017-07-06 06:34:13
categories: pconstants update
---
It has been reported that `:constant_missing` could be useful in accessing java enums, but [my experiments][github] make me doubt its value. See prevoius post for a more convential approach. As far as I can tell the redefining of :constant missing is somewhat similar to `include Constants` module with in this case `Axis`, `RenderMode` and `Shapes` as the available constants _you still need to access the actual enums_ by prefix the enum name `Axis::X`

### Requirements

Requires JRuby, maven

### The test employing :constant_missing

```ruby
# frozen_string_literal: true
require 'java'
require_relative 'test_helper'
require_relative '../lib/pconstants'

module Constants
  include_package 'processing.core.enums'
end

# P3D = Constants::RenderMode::P3D
# X = Constants::Axis::X
# CURVE_VERTEX = Constants::Shapes::CURVE_VERTEX

class Object
  class << self
    alias :const_missing_old :const_missing
    def const_missing c
      Constants.const_get c
    end
  end
end

class SpecTest < Minitest::Test

  def test_constants_is_a_module
    assert_equal Class, Axis.class, 'Constants not recognized as a module'
  end

  def test_p3d
    assert_equal String, RenderMode::P3D.render_mode.class, "failed #{:P3D} is a string"
    assert_equal Java::JavaLang::String, RenderMode::P3D.render_mode.to_java(:string).class, "failed #{:P3D} can be cast as a java string"
    assert_equal 'processing.opengl.PGraphics3D', RenderMode::P3D.render_mode, "failed #{:P3D} lookup"
  end

  def test_numeric
    assert_equal 0, Axis::X.get_axis, "failed #{:X} lookup"
    assert_equal 3, Shapes::CURVE_VERTEX.shape, "failed #{:CURVE_VERTEX} lookup"
  end
end
```

### The Axis enum file

```java
/*
Use of enums is preferred for global access, however the general
recommendation is to include constants in classes that use them.
*/
package processing.core.enums;

public enum Axis {
  X(0),
  Y(1),
  Z(2);

  Axis(int val) {
    this.axis = val;
  }

  public int getAxis(){
    return this.axis;
  }
  private final int axis;
}

```

### The RenderMode enum file

```java
/*
 Use of enums is preferred for global access, however the general
 recommendation is to include constants in classes that use them.
*/
package processing.core.enums;

public enum RenderMode {
   JAVA2D("processing.awt.PGraphicsJava2D"),
   P2D("processing.opengl.PGraphics2D"),
   P3D("processing.opengl.PGraphics3D"),
   FX2D("processing.javafx.PGraphicsFX2D"),
   PDF("processing.pdf.PGraphicsPDF"),
   SVG("processing.svg.PGraphicsSVG"),
   DXF("processing.dxf.RawDXF");

   RenderMode(String val) {
       this.mode = val;
   }

   private final String mode;

   public String renderMode(){
       return this.mode;
   }
}

```

### The Shapes enum file

```java
/*
 Use of enums is preferred for global access, however the general
 recommendation is to include constants in classes that use them.
*/
package processing.core.enums;

public enum Shapes {
   VERTEX(0),
   BEZIER_VERTEX(1),
   QUADRATIC_VERTEX(2),
   CURVE_VERTEX(3),
   BREAK(4);

   Shapes(int val) {
       this.shape = val;
   }

   private final int shape;

   public int getShape() {
       return this.shape;
   }
}

```

[github]:https://github.com/ruby-processing/PConstants
[jruby_art]:https://github.com/ruby-processing/JRubyArt
[propane]:https://github.com/ruby-processing/propane
