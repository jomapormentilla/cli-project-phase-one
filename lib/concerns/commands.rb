module Commands
    module ClassMethods
    end

    module InstanceMethods
        def view_profile
            puts "           NAME: #{ self.info.name }"
            puts "          HOUSE: #{ self.info.house.name }"
            puts "         SPELLS: #{ self.info.spells.uniq.length }"
            puts "        FRIENDS: #{ self.info.friends.uniq.length }"
            puts "        ENEMIES: #{ self.info.enemies.uniq.length }"
            puts "  POINTS EARNED: #{ self.info.house.house_points }"
        end

        def view_friends
            my_friends = self.info.friends
            if my_friends == []
                puts "\n=> You don't have any friends.\n"
            else
                my_friends.each.with_index(1){ |friend, index| puts "       #{ index }. #{ friend.name }" }
            end
        end

        def view_enemies
            puts "#{ self.info.name }'s enemies:\n"
            my_enemies = self.info.enemies
            if my_enemies == []
                puts "\n=> You don't have any enemies.\n"
            else
                my_enemies.each.with_index(1){ |enemy, index| puts "       #{ index }. #{ enemy.name }" }
            end
        end

        def list_professors
            puts "  Hogwarts Professors:\n"
            Professor.all.collect.with_index(1){ |wizard, index| puts "     #{ index }. #{ wizard.name }" }
        end

        def list_students
            puts "  Hogwarts Students:\n"
            Student.all.collect.with_index(1){ |wizard, index| puts "     #{ index }. #{ wizard.name }" }
        end

        def list_houses
            House.all.each.with_index(1) do |house, index|
                puts "#{ index }. #{ house.name.upcase }"
                puts "   Founder: #{ house.founder }"
                puts "   Head Master: #{ house.head_master }"
                puts "   Mascot: #{ house.mascot.capitalize }"
                puts "   House Points: #{ house.house_points }\n\n"
            end
        end

        def find_wizard
            puts "Please enter the First, Last, or Full Name of the Wizard you would like to find: \n\n"
            input = gets.strip
            result = Wizard.find_by_first_or_last_name( input )

            if input == "" || result == nil
                puts "\n=> Sorry, it seems #{ input } does not go to Hogwarts! Try searching a different name:"
                find_wizard
            elsif input == "0"
                main_menu
            elsif input == self.info.name
                puts "\n=> Last we checked, there is only ONE of you. Try searching for another wizard."
                find_wizard
            else
                if result.house != nil
                    puts "\n=> #{ result.name } is a #{ result.role } from House #{ result.house.name }."
                else
                    puts "\n=> #{ result.name } is a #{ result.role }."
                end
                friend_wizard( result )
            end
        end

        def friend_wizard( wizard )
            puts "Would you like to add #{ wizard.name } as a friend? (y/n)"
            
            input = gets.strip
            if input == "y"
                output = "Great! You are now friends with #{ wizard.name }!"
                puts "\n=> #{ output }"
                self.info.add_friend( wizard )
            elsif input == "n"
                output = "Uh oh, you have upset #{ wizard.name }! You are now enemies."
                puts "\n=> #{ output }"
                self.info.add_enemy( wizard )
            end
            add_to_history( output )
        end

        def find_spell
            puts "Please enter the name of a spell: \n\n"
            input = gets.strip
            result = Spell.find_spell_by_first_or_last_name( input )


            if input == "" || result == nil
                puts "\n=> Sorry, it seems #{ input } is not a valid Spell! Try searching a different name:"
                find_spell
            elsif input == "0"
                main_menu
            else
                puts "\n=> Found: #{ result.name }. Effect: #{ result.effect }"
            end
            
            puts "Would you like to learn #{ result.name }? (y/n)"

            gets.strip == "y" ? self.info.learn_spell( result ) : nil
        end

        def view_spells
            puts "Here are all the spells you currently know:\n\n"
            
            if self.info.spells == []
                puts "\n=> You don't know any spells.\n"
            else
                self.info.spells.uniq.each{ |spell| 
                    puts "    Name: #{ spell.name }" 
                    puts "    Type: #{ spell.type }"
                    puts "  Effect: #{ spell.effect.split.map(&:capitalize).join(" ") }"

                    wizards_who_know_this = spell.owner.uniq.collect{ |owner| owner.name }
                    puts "Owned By: #{ wizards_who_know_this.join(", ") }\n\n"
                }
            end
        end

        def learn_spell
            all_spells = Spell.all.collect.with_index(1){ |spell, index| puts "#{ index }. #{ spell.name }" }
            
            puts "Which spell would you like to learn?"
            input = gets.strip.to_i
            if input.between?(0, all_spells.length)
                new_spell = Spell.all[input-1]
                self.info.learn_spell( new_spell )

                output = "Congratulations! You have learned #{ new_spell.name }!"
                puts "\n=> #{ output }"
                
                add_to_history( output )
            else
                welcome_banner
                puts "=> Invalid Selection"
                learn_spell
            end
        end

        def create_spell
            result = []
            puts "What would you like to name this spell?"
            result << gets.strip

            puts "What are the effects of this spell?"
            result << gets.strip

            new_spell = Spell.new( result[0], 'Spell', result[1], self )
            new_spell.owner = self.info
            self.info.spells << new_spell

            output = "Congratulations! You created #{ result[0] }."
            puts "=> #{ output }\n\n"

            add_to_history( output )
        end

        def teach_spell
            puts "Need to Implement This."
        end
    end
end