module Findable

    module ClassMethods
        def find_by_name( input )
            self.all.find{ |data| data.name == input }
        end
    end

    module InstanceMethods
        def learn_spell( spell )
            self.spells << spell
            spell.owner = ( self )
        end

        def create_spell( name, type, effect )
            new_spell = Spell.new( name, type, effect, self )
            new_spell.owner = self
            self.spells << new_spell
            self.spells.collect{ |spell| spell.name }   # return an array of Spells that this particular instance owns
        end
    end
end