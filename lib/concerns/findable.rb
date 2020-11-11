module Findable

    module ClassMethods
        def find_by_name( input )
            self.all.find{ |data| data.name == input }
        end

        def find_by_first_or_last_name( input )
            name_arr = self.all.collect{ |data|
                data.name.split
            }

            find_name = name_arr.select{ |data|
                if data[0].class != NilClass && data[1].class != NilClass
                    input.downcase == data[0].downcase || input.downcase == data[1].downcase
                elsif data[0].class != NilClass
                    input.downcase == data[0].downcase
                end
            }
            
            if find_name.size == 1
                self.find_by_name( find_name[0].join(" ") )
            elsif find_name.size > 1
                puts "Found the following Wizards:"
                find_name.each.with_index(1) do |data, index|
                    puts "#{ index }. #{ data[0] } #{ data[1] }"
                end

                input = gets.strip.to_i
                if input.between?(0,find_name.length)
                    data = find_name[input-1].join(" ")
                    self.find_by_name( data )
                end
            end
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
            list_spells
        end

        def list_spells
            self.spells.collect{ |spell| spell.name }
        end

        def teach_spell( spell, student )
            student.learn( spell )
        end
    end
end