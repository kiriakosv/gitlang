require 'test_helper'

class RepositoryTest < Minitest::Test
  def setup
    @client = Octokit::Client.new access_token: ENV['GITHUB_TOKEN']
    @repository = Gitlang::Repository.new('acme', 'boom', @client)
  end

  def test_that_full_name_returns_the_correct_name
    assert_equal @repository.full_name, 'acme/boom'
  end

  def test_that_languages_returns_the_correct_hash
    @client.stub :languages, python: 1000, c: 200 do
      assert_equal @repository.languages, python: 1000, c: 200
    end
  end

  def test_that_languages_raises_gitlang_error_when_appropriate
    raise_error = ->(_) { raise Octokit::NotFound.new, 'message' }
    @client.stub :languages, raise_error do
      assert_raises Gitlang::GitlangError do
        @repository.languages
      end
    end
  end
end
