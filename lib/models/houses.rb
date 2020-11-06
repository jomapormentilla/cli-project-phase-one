class Houses
    attr_accessor :id, :name, :mascot, :founder, :head_master

    @@all = []

    def initialize( id, name, mascot, founder, head_master )
        @id = id
        @name = name
        @mascot = mascot
        @founder = founder
        @head_master = head_master

        @@all << self
    end

    def self.all
        @@all
    end
end