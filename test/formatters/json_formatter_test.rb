require 'test_helper'

class JsonFormatterTest < Minitest::Test
  def test_that_format_returns_the_correct_string
    formatter = Gitlang::JsonFormatter.new
    expected = '{
  "organization": "acme",
  "languages": {
    "c": 30,
    "ruby": 70
  }
}'

    assert_equal formatter.format('acme', c: 30, ruby: 70), expected
  end
end
