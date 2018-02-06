require 'test_helper'

class OrganizationTest < Minitest::Test
  def setup
    dummy_resources, dummy_response = stub_sawyer
    @client = Octokit::Client.new access_token: ENV['GITHUB_TOKEN']

    @client.stub :org_repos, dummy_resources do
      @client.stub :last_response, dummy_response do
        @organization = Gitlang::Organization.new('acme', @client)
      end
    end
  end

  def test_that_usage_per_repo_returns_an_array_of_hashes
    @organization.repositories[0].stub :languages, c: 3, python: 5 do
      @organization.repositories[1].stub :languages, c: 8, python: 5 do
        assert_equal @organization.usage_per_repo, [{ c: 3, python: 5 },
                                                    { c: 8, python: 5 }]
      end
    end
  end
end
