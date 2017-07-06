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
