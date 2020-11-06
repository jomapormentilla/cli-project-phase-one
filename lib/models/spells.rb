class Spells
    attr_accessor :id, :name, :type, :effect

    @@all = []

    def initialize( id, name, type, effect )
        @id = id
        @name = name
        @type = type
        @effect = effect

        @@all << self
    end

    def self.all
        @@all
    end
end