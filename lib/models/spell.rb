class Spell
    extend Findable::ClassMethods

    attr_accessor :name, :type, :effect, :owner

    @@all = []

    def initialize( name, type, effect, owner=nil )
        @name = name
        @type = type
        @effect = effect
        @owner = []

        @@all << self
    end

    def self.all
        @@all
    end

    def owner=( wizard )
        @owner << wizard
    end
end