require 'test_helper'

class GithubStatsTest < Minitest::Test
  def setup
    @object = Object.new
    @object.extend Gitlang::GithubStats
    @usage = [{ c: 40, python: 2 }, { c: 2, python: 40 }, { ruby: 4 }]
  end

  def test_that_absolute_usage_per_language_returns_correct_values
    expected = { c: 42, python: 42, ruby: 4 }
    assert_equal @object.absolute_usage_per_language(@usage), expected
  end

  def test_that_relative_usage_per_language_returns_correct_values
    expected = { c: 47.73, python: 47.73, ruby: 4.54 }
    relative_usage = @object.relative_usage_per_language(@usage)
    assert_equal relative_usage, expected
    assert_equal relative_usage.values.inject(&:+), 100
  end

  def test_that_relative_usage_per_language_returns_an_empty_hash_when_input_is_an_empty_hash
    relative_usage = @object.relative_usage_per_language({})
    assert_equal relative_usage, {}
  end
end
