require 'bigdecimal'
require 'lare_round'

module Gitlang
  # Module for extracting useful Github statistics.
  module GithubStats
    # Creates a hash with the absolute usage for each language.
    #
    # @param usage_per_repo [Array<Hash>]
    #
    # @example
    #   absolute_usage_per_language([{ python: 4, ruby: 2 }, { python: 3 }])
    def absolute_usage_per_language(usage_per_repo)
      usage_per_repo.each_with_object(Hash.new(0)) do |repository, total|
        repository.each { |language, usage| total[language] += usage }
      end
    end

    # Creates a hash with the relative usage for each language.
    #
    # @param usage_per_repo [Array<Hash>]
    #
    # @example
    #   relative_usage_per_language([{ python: 30, ruby: 70 }, { python: 100 }])
    def relative_usage_per_language(usage_per_repo)
      absolute_usage = absolute_usage_per_language(usage_per_repo)
      total = absolute_usage.values.inject(&:+)
      results_pre_lare = absolute_usage.merge(absolute_usage) do |_, usage|
        (BigDecimal.new(usage) / total * 100)
      end

      return results_pre_lare if results_pre_lare.empty?

      # Largest remainder method is used in order to avoid cases where the sum
      # of the relative usage is over or under 100%.
      # More info at https://en.wikipedia.org/wiki/Largest_remainder_method.
      results_after_lare = LareRound.round(results_pre_lare, 2)
      results_after_lare.merge(results_after_lare) { |_, usage| usage.to_f }
    end
  end
end
