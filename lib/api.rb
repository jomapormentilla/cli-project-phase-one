# Class method, responsible for talking with our API

class API
    attr_reader :url_base, :api_key

    def initialize
        @url_base = "https://www.potterapi.com/v1/"
        @api_key = "$2a$10$54kkWPrtIA6zbGri3jkccOKg0kwMdmfJg1344F3p2qzPFBFZfZqAC"
        start
    end

    def start
        # Load all data from APIs
        get_spells
        get_houses
        get_characters
    end

    def get_data( type )
        url = @url_base + type + "?key=" + @api_key
        uri = URI( url )                    # Turns the URL into an HTTP Object that we can use in our program
        response = Net::HTTP.get( uri )     # Returns a response as a String Object
        arr = JSON.parse( response )        # Converts the response String to a JSON format
    end

    def get_spells
        spells = get_data("spells").uniq
        spells.each.with_index{ |spell, index| Spell.new( index, spell["spell"], spell["type"], spell["effect"] ) }
    end
    
    def get_houses
        houses = get_data("houses").uniq
        houses.each{ |house| House.new( house["name"], house["mascot"], house["founder"], house["headOfHouse"]) }
    end

    def get_characters
        characters = get_data("characters").uniq
        characters.each{ |character|
        if character["role"] != nil
                role_formatted = character["role"].split(", ")[0].capitalize
                if role_formatted == "Student"
                    Student.new( character["name"], role_formatted, character["house"] )
                elsif role_formatted == "Professor"
                    Professor.new( character["name"], role_formatted, character["house"] ) 
                else
                    Wizard.new( character["name"], role_formatted, character["house"] ) 
                end
            end
        }
    end
end