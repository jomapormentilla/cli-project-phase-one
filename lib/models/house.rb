class House
    extend Findable::ClassMethods

    attr_accessor :name, :mascot, :founder, :head_master, :house_points

    @@all = []

    def initialize( name, mascot, founder, head_master )
        @name = name
        @mascot = mascot
        @founder = founder
        @head_master = head_master
        @house_points = rand(1..1000)

        @@all << self
    end

    def self.all
        @@all
    end

    def add_character( character )
        character.house = self
    end

    def house_points=( house_points )
        @house_points += house_points
    end
end