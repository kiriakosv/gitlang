require 'gitlang/github_stats'
require 'gitlang/repository'
require 'gitlang/utilities'

module Gitlang
  # Class representing a GitHub organization
  class Organization
    include Gitlang::GithubStats
    include Gitlang::Utilities

    attr_reader :name, :repositories

    def initialize(name, client)
      @name = name.downcase
      @client = client
      @repositories = fetch_repo_names.each_with_object([]) do |repo_name, repositories|
        # There is a tight coupling between Organisation and Repository, but I
        # think it's fine regarding the scope of the application.
        repositories << Repository.new(@name, repo_name, @client)
      end
    end

    # Creates an array of hashes with the language usage for each repository.
    def usage_per_repo
      conditional_rescue do
        @repositories.each_with_object([]) do |repository, result|
          result << repository.languages
        end
      end
    end

    private

    def fetch_repo_names
      conditional_rescue { fetch_all_pages.flatten }
    end

    # Get every repository name. Acts as a helper for fetch_repo_names since
    # we're dealing with an external paginated service.
    def fetch_all_pages
      result = @client.org_repos(name,
                                 query: { type: 'sources', visibility: 'public' },
                                 per_page: 100)
                      .map(&:name)
      last_response = @client.last_response

      until last_response.rels[:next].nil?
        last_response = last_response.rels[:next].get
        result << last_response.data.map(&:name)
      end

      result
    end
  end
end
