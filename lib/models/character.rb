class Character
    attr_accessor :name, :role, :house

    @@all = []

    def initialize( name, rolse, house )
        @name = name
        @role = role
        @house = house

        @@all << self
    end

    def self.all
        @@all
    end
end