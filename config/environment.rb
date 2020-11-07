require 'bundler' 
Bundler.require     # Requires ALL Gems listed in the Gemfile

# CONCERNS / MODULES
require_relative '../lib/concerns/commands'
require_relative '../lib/concerns/findable'

# API & CLI
require_relative '../lib/api'
require_relative '../lib/cli'

# CLASS MODELS
require_relative '../lib/models/spell'
require_relative '../lib/models/house'
require_relative '../lib/models/wizard'
require_relative '../lib/models/student'
require_relative '../lib/models/professor'