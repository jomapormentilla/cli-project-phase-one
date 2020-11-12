require 'open-uri'
require 'nokogiri'

class API
    attr_reader :url_base, :url_fandom

    def initialize
        @url_base = "http://hp-api.herokuapp.com/api/"
        @url_spells = "https://www.pojo.com/harry-potter-spell-list/"
        @url_houses = "https://pottermore.fandom.com/wiki/Houses"

        start
    end
    
    def start
        get_characters
        get_spells
        get_houses
    end
    
    def get_data( type )
        url = @url_base + type
        uri = URI( url )                    # Turns the URL into an HTTP Object that we can use in our program
        response = Net::HTTP.get( uri )     # Returns a response as a String Object
        arr = JSON.parse( response )        # Converts the response String to a JSON format 
    end

    def get_spells
        spells = spell_scraper( @url_spells )
        spells.each{ |spell| Spell.new( spell[:name], spell[:type], spell[:effect] ) }
    end
    
    def get_houses
        houses = house_scraper( @url_houses )
        houses.each{ |house| House.new( house[:name], house[:mascot], house[:founder], house[:head_master]) }
    end

    def get_characters
        characters = get_data("characters").uniq
        characters.each{ |character|
            if character["hogwartsStudent"]
                student = Student.new( character["name"], "Student", character["house"] )
                # student.learn_spell( Spell.all.sample )     # Learns a random spell on initialization
            elsif character["hogwartsStaff"]
                professor = Professor.new( character["name"], "Professor", character["house"] ) 
                # professor.learn_spell( Spell.all.sample )   # Learns a random spell on initialization
            else
                professor = Wizard.new( character["name"], "Staff", character["house"] ) 
                # professor.learn_spell( Spell.all.sample )   # Learns a random spell on initialization
            end
        }
    end

    def spell_scraper( url )
        html = Nokogiri::HTML(open(url))

        array = []
        html.css("tbody tr").each do |tbody|
            if tbody.css("td")[0].text != "Incantation" && tbody.css("td")[0].text.length > 3
                hash = {
                    name: tbody.css("td")[0].text,
                    type: tbody.css("td")[1].text,
                    effect: tbody.css("td")[2].text
                }
                array << hash
            end
        end
        array
    end

    def house_scraper( url )
        html = Nokogiri::HTML(open(url))

        array = []
        html.css(".infoboxtable tbody").each do |tbody|
            hash = {
                name: tbody.css("td")[2].css("p").text.split[1],
                founder: tbody.css("td")[2].css("p").text,
                mascot: tbody.css("td")[6].css("p").text,
                head_master: tbody.css("td")[10].css("p").text
            }
            array << hash
        end
        array
    end
end