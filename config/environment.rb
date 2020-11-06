require 'bundler' 
Bundler.require     # Requires ALL Gems listed in the Gemfile

require_relative '../lib/api'
require_relative '../lib/cli'

# Models
require_relative '../lib/models/spells'
require_relative '../lib/models/houses'