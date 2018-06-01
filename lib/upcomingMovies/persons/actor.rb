module Persons
    class UpcomingMovies::Actor < UpcomingMovies::Person
        extend ::Helper

        @@all = []

        def self.all
            @@all
        end

        def self.find_by_name(name) 
            @@all.detect {|actor| actor.name == name}
          end

        def self.create_by_name(name)
            actor = self.new({:name=>name})
            @@all << actor
            actor
        end

        def self.find_or_create_by_name(name)
            find_by_name(name) || create_by_name(name)
        end

        def self.actors_this_week
            date = date_of_next_or_this_friday
            actors = []
            @@all.each do |actor|
                actor.movies.each do |movie|
                    day = sprintf("%02i", movie.date)
                    if Helper.months[movie.month] == date[0] && day == date[1] && movie.year == date[2]
                        actors << actor
                        break
                    end
                end
            end
            actors
        end

        def self.actors_this_month
            current_info = current_month_year
            actors = []
            @@all.each do |actor|
                actor.movies.each do |movie|
                    if movie.month == current_info[0] && movie.year == current_info[1] && movie.futureMovie?
                        actors << actor
                        break
                    end
                end
            end
            actors
        end
    end
end
