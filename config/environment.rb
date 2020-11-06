require 'bundler' 
Bundler.require     # Requires ALL Gems listed in the Gemfile

require_relative '../lib/api'
require_relative '../lib/cli'

# Models
require_relative '../lib/models/spell'
require_relative '../lib/models/house'
require_relative '../lib/models/character'
require_relative '../lib/models/student'
require_relative '../lib/models/professor'