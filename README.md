# Gitlang

Simple gem for displaying information about the programming languages used by a GitHub organization.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gitlang'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gitlang

## Setup

This gem makes several requests to the GitHub API. In order to avoid rate limit restrictions follow the instructions below:
* Create a Personal Access Token as described in the *Creating a token* section [here](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/).
* Open your terminal and run:
```bash
export GITHUB_TOKEN=[token]
```
Note that this command sets this variable only for the current session. If you want persistence you can set it in a configuration file, depending on your terminal.

## Usage

Open your terminal and run:
```bash
gitlang relative_usage_per_language [organization_name]

# Returns a prettified json formatted string, the numbers are expressed as %.
# {
#   "organization": organization_name,
#   "languages": {
#       "language1": 40.0,
#       "language2": 60.0
#    }
# }
```
This gem can be used in conjuction with the redirection operators. For example, if you want to store the output in a file you can run:
```
gitlang relative_usage_per_language [organization_name] > [file_name]
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
