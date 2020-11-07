module Findable
    module ClassMethods
        def find_by_name( input )
            self.all.find{ |data| data.name == input }
        end
    end
end