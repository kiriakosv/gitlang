module Gitlang
  # Contains general purpose methods.
  module Utilities
    # Calls the given block and rescues from specific errors.
    #
    # @yield block
    #
    # @example
    #   conditional_rescue { @client.call }
    def conditional_rescue
      yield if block_given?
    rescue Octokit::TooManyRequests
      raise Gitlang::GitlangError,
            'You made too many requests. Please set GITHUB_TOKEN.'
    rescue Octokit::NotFound
      raise Gitlang::GitlangError, 'Resource not found.'
    rescue Octokit::Unauthorized
      raise Gitlang::GitlangError, 'Wrong GITHUB_TOKEN.'
    rescue Faraday::ConnectionFailed
      raise Gitlang::GitlangError, 'Connection failed.'
    end
  end
end
