require 'pry'

class UpcomingMovies::Movie
    extend ::Persons
    extend ::Helper
    attr_accessor :name, :description, :month, :date, :year, :actors, :url, :runtime, :genre,
        :rating

    @@all = []
    def initialize(movie_attributes)
        movie_attributes.each{|key, value| self.send(("#{key}="), value)}
        @@all << self
    end

    def add_actor(name)
        actor = UpcomingMovies::Actor.find_or_create_by_name(name)    
        if !self.actors.any?{|a| a.name == name }
            self.actors << actor
        end 
    end

    def add_self_to_actor
        if self.actors
            self.actors.each do |actor|
                if actor.movies
                    if !actor.movies.any?{|movie| movie.name == self.name}
                        actor.instance_variable_set(:@movies, [self])
                    end
                else
                    actor.instance_variable_set(:@movies, [self])
                end
            end
        end
    end

    def add_attributes(movie_attributes)
        movie_attributes.each {|key, value| self.send(("#{key}="), value)}
    end

    def self.all
        @@all
    end

    #class method returns all upcoming movies if movie is in the future
    def self.all_in_future
        @@all.select {|movie| movie if movie.futureMovie?}
    end

    def self.movies_this_week
        date = date_of_next_or_this_friday
        moviesInWeek = @@all.select do |movie|
            day = sprintf("%02i", movie.date)
            if Helper.months[movie.month] == date[0] && day == date[1] && movie.year == date[2]
                movie
            end
        end
        moviesInWeek
    end

    def self.movies_this_month
        current_info = current_month_year
        movieMonth = @@all.select {|movie| movie if movie.month == current_info[0] && 
            movie.year == current_info[1] && movie.futureMovie?}
        movieMonth
    end

    #class method that checks whether or not the movie release date is in the future
    def futureMovie?
        strDate = @year + "-" + Helper.months[@month] + "-" + sprintf("%02i", @date)
        newDate = Date.parse(strDate)
        today = Date.today
        result = newDate >= today ? true : false
    end

end