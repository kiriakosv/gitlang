require 'test_helper'

class UtilitiesTest < Minitest::Test
  def setup
    @object = Object.new
    @object.extend Gitlang::Utilities
  end

  def test_that_conditional_rescue_returns_normally_if_no_error_happened
    result = @object.conditional_rescue { 40 + 2 }
    assert_equal result, 42
  end

  def test_that_conditional_raises_the_appropriate_error_if_needed
    assert_raises Gitlang::GitlangError do
      @object.conditional_rescue { raise Octokit::NotFound }
    end
  end
end
