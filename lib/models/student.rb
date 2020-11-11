class Student < Wizard
    def self.all
        @@all.select{ |character| character.role == "Student" }
    end

    def add_friend( wizard )
        if @enemies.detect{ |name| name == wizard }
            @enemies.delete( wizard )
        end
        @friends << wizard
    end

    def add_enemy( wizard )
        if @friends.detect{ |name| name == wizard }
            @friends.delete( wizard )
        end
        @enemies << wizard
    end

    def earn_points

    end

    def lose_points

    end

    def list_housemates
        @@all.select{ |student| student.house == self.info.house }
    end
end