# Class method, responsible for talking with our API

class API
    def self.start
        url = "https://www.potterapi.com/v1/spells?key=$2a$10$54kkWPrtIA6zbGri3jkccOKg0kwMdmfJg1344F3p2qzPFBFZfZqAC"
        uri = URI( url )                    # Turns the URL into an HTTP Object that we can use in our program
        response = Net::HTTP.get( uri )     # Returns a response as a String Object
        arr = JSON.parse( response )        # Converts the response String to a JSON format
        
        spells = arr
        binding.pry
    end
end