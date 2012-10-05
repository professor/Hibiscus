# Load the rails application
require File.expand_path('../application', __FILE__)
require 'yaml'

#Force Hibiscus to use syck to load momgoid YAML
YAML::ENGINE.yamler='syck'
# Initialize the rails application
CraftWiki::Application.initialize!
