require 'gitlang/utilities'

module Gitlang
  # Class representing a GitHub organization's repository.
  class Repository
    include Gitlang::Utilities

    def initialize(organization_name, repository_name, client)
      @organization_name = organization_name
      @name = repository_name
      @client = client
    end

    # Returns the full name of the repository as a string.
    def full_name
      @organization_name + '/' + @name
    end

    # Returns a hash containing the absolute usage of each language.
    def languages
      conditional_rescue { @client.languages(full_name) }
    end
  end
end
