# frozen_string_literal: true
require 'java'
require_relative 'test_helper'
require_relative '../lib/pconstants'

java_import Java::ProcessingCore::PConstants

class SpecTest < Minitest::Test
  include PConstants

  def test_pconstants_is_a_module
    assert_equal Module, PConstants.class, 'PConstants not recognized as a Module'
  end

  def test_p3d
    assert_equal String, P3D.class, "failed #{:P3D} is a string"
    assert_equal Java::JavaLang::String, P3D.to_java(:string).class, "failed #{:P3D} can be cast as a java string"
    assert_equal 'processing.opengl.PGraphics3D', P3D, "failed #{:P3D} lookup"
  end

  def test_numeric
    assert_equal 8, TRIANGLE, "failed #{:TRIANGLE} lookup"
    assert_in_delta 3.14159, PI, 0.001, "failed #{:PI} lookup"
  end
end
