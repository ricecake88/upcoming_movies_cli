module Persons
    class Actor < Person
        attr_accessor :movies

        @@all = []
        #temp class for setting actor stub data
        def add_movie(movie)
            @movies << movie
            movie.actor = self
        end

        #returns Actors only
        def self.all
            @@all
        end

        def create_by_name(name)
            actor = self.new(name)
            @@all << actor
            actor
        end
    end
end