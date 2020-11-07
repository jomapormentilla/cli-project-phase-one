class Professor < Wizard
    # Can teach spells

    def self.all
        @@all.select{ |character| character.role == "Professor" }
    end

    def teach_spell( spell, student )
        student.learn( spell )
    end
end