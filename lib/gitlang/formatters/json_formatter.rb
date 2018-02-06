require 'json'

module Gitlang
  # A class for formatting various results to JSON format.
  class JsonFormatter
    # Create a JSON formatted string for the data provided.
    #
    # @param organization_name [String]
    # @param languages [Hash]
    #
    # @example
    #   format('acme', { c: 30.0, ruby: 70.0 })
    def format(organization_name, languages)
      JSON.pretty_generate(organization: organization_name,
                           languages: languages)
    end
  end
end
