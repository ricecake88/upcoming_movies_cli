module Persons
    class UpcomingMovies::Actor < UpcomingMovies::Person

        @@all = []

        #returns Actors only
        def self.all
            @@all
        end

        def self.find_by_name(name) 
            @@all.detect {|actor| actor.name == name}
          end

        def self.create_by_name(name)
            actor = self.new(name)
            @@all << actor
            actor
        end

        def self.find_or_create_by_name(name)
            find_by_name(name) || create_by_name(name)
        end
    end
end