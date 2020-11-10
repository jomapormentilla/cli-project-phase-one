class Professor < Wizard
    # Can teach spells

    def self.all
        @@all.select{ |character| character.role == "Professor" }
    end
end