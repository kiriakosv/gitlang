$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'gitlang'

require 'minitest/autorun'

def stub_sawyer
  dummy_resources = %w[repo1 repo2].each_with_object([]) do |name, resources|
    resources << Sawyer::Resource.new(Sawyer::Agent.new('www.dummy.com'),
                                      name: name)
  end

  dummy_response = Sawyer::Response.new(Sawyer::Agent.new('www.dummy.com'),
                                        Faraday::Response.new)
  [dummy_resources, dummy_response]
end
