# Command line interface
# Interacts with the user
# Connects our files together

class Cli
    include Commands::InstanceMethods
    attr_accessor :name, :house, :info, :commands, :history

    def initialize
        @history = []
        start
        level_one_commands
    end
end