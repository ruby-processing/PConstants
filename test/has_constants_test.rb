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
