class Student < Character
    attr_accessor :friends, :enemies, :status

    # The User will insantiate as a new Student
    # Knows which house they belong to
    # Can make friends
    # Can make enemies
    # Can earn and lose house points
    # Can be expelled

    def self.all
        @@all.select{ |character| character.role == "Student" }
    end

    def learn_spell( spell )
        @spells << spell
    end

    def create_spell( name, type=nil, effect )
        Spell.new( name, type, effect )
    end

    def add_friend( character )

    end

    def add_enemy( character )

    end

    def earn_points

    end

    def lose_points

    end
end