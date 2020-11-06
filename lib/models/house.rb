class House
    attr_accessor :name, :mascot, :founder, :head_master, :house_points

    @@all = []

    def initialize( name, mascot, founder, head_master )
        @name = name
        @mascot = mascot
        @founder = founder
        @head_master = head_master
        @house_points = 0

        @@all << self
    end

    def self.all
        @@all
    end

    def add_character( character )
        character.house = self
    end
end