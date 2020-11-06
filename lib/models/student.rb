class Student
    attr_accessor :name, :house, :spells, :friends, :enemies, :status

    @@all = []

    def initialize( name, house )
        @name = name
        @house = house
        @status = "Enrolled"

        @@all << self
    end

    def self.all
        @@all
    end

    # The User will insantiate as a new Student
    # Knows which house they belong to
    # Can learn spells
    # Can make friends
    # Can make enemies
    # Can earn and lose house points
    # Can be expelled

    def learn_spell

    end

    def add_friend

    end

    def add_enemy

    end

    def earn_points

    end

    def lose_points

    end
end