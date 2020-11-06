class House
    attr_accessor :id, :name, :mascot, :founder, :head_master, :house_points

    @@all = []

    def initialize( id, name, mascot, founder, head_master )
        @id = id
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
end