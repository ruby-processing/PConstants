# frozen_string_literal: true
require 'java'
require_relative 'test_helper'
require_relative '../lib/pconstants'

module Constants
  java_import 'processing.core.Axis'
  java_import 'processing.core.RenderMode'
  java_import 'processing.core.Shapes'
end

class SpecTest < Minitest::Test
  include Constants

  def test_constants_is_a_module
    assert_equal Module, Constants.class, 'Constants not recognized as a module'
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
