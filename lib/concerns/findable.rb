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
                if data[0].class != NilClass
                    data[0].downcase == input.downcase
                elsif data[0].class != NilClass && data[1].class != NilClass
                    data[0].downcase == input.downcase || data[1].downcase == input.downcase
                end
            }

            if find_name.size == 1
                self.find_by_name( find_name[0].join(" ") )
            elsif find_name.size > 1
                puts "Found the following Wizards:"
                find_name.each.with_index(1) do |wizard, index|
                    puts "#{ index }. #{ wizard[0] } #{ wizard[1] }"
                end

                input = gets.strip.to_i
                if input.between?(0,find_name.length)
                    wizard = find_name[input-1].join(" ")
                    self.find_by_name( wizard )
                end
            end
        end

        def find_spell_by_first_or_last_name( input )
            name_arr = self.all.collect{ |data|
                data.name.split
            }

            find_name = name_arr.select{ |data|
                if data[0].class != NilClass
                    data[0].downcase == input.downcase
                elsif data[0].class != NilClass && data[1].class != NilClass
                    data[0].downcase == input.downcase || data[1].downcase == input.downcase
                end
            }

            if find_name.size == 1
                self.find_by_name( find_name[0].join(" ") )
            elsif find_name.size > 1
                puts "Found the following Spells:"
                find_name.each.with_index(1) do |spell, index|
                    puts "#{ index }. #{ spell[0] } #{ spell[1] }"
                end

                input = gets.strip.to_i
                if input.between?(0,find_name.length)
                    spell = find_name[input-1].join(" ")
                    self.find_by_name( spell )
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