class Spell
    extend Findable::ClassMethods

    attr_accessor :id, :name, :type, :effect, :owner

    @@all = []

    def initialize( id, name, type, effect, owner=nil )
        @id = id
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