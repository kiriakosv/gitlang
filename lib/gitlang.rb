require 'thor'
require 'octokit'
require 'tty-spinner'

require 'gitlang/version'
require 'gitlang/organization'
require 'gitlang/formatters/json_formatter'
require 'gitlang/errors'

module Gitlang
  # Class containing the commands that the final user can use.
  class CLI < Thor
    def initialize(*args)
      super
      @client = Octokit::Client.new access_token: ENV['GITHUB_TOKEN']
      @formatter = JsonFormatter.new
      @spinner = TTY::Spinner.new('[:spinner] Data crunching... ')
    end

    def self.exit_on_failure?
      true
    end

    desc 'relative_usage_per_language [name]',
         'Returns the relative usage per language for a given organization.'
    def relative_usage_per_language(organization)
      @spinner.auto_spin
      @organization = Organization.new(organization, @client)
      usage_per_repo = @organization.usage_per_repo
      relative_usage = @organization.relative_usage_per_language(usage_per_repo)
      puts @formatter.format(@organization.name, relative_usage)
      @spinner.success('Done')
    rescue GitlangError => e
      @spinner.error('Failure: - ' + e.message)
    end
  end
end
