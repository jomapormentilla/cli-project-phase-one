class Cli
    include Clistrict::InstanceMethods
    include Navigation::InstanceMethods
    include Commands::InstanceMethods
    
    attr_accessor :name, :house, :info, :commands, :history

    def initialize
        @history = []
        start
        main_menu
    end
end