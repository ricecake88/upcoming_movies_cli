require 'pry'

class UpcomingMovies::Movie
    extend ::Persons
    extend ::Helper
    attr_accessor :name, :description, :month, :date, :year, :actors, :url, :runtime, :genre,
        :rating
    @@months = {'January'=>'01', 
        'February'=>'02', 
        'March'=>'03', 
        'April'=>'04', 
        'May'=>'05', 
        'June'=>'06', 
        'July'=>'07', 
        'August'=>'08', 
        'September'=>'09', 
        'October'=>'10', 
        'November'=>'11', 
        'December'=>'12'}

    @@all = []
    def initialize(movieAttributes)
        movieAttributes.each{|key, value| self.send(("#{key}="), value)}
        @@all << self
    end

    def add_actor(name)
        actor = UpcomingMovies::Actor.find_or_create_by_name(name)    
        if !self.actors.any?{|a| a.name == name }
            self.actors << actor
        end 
    end

    def add_self
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

    def add_attributes(movieAttributes)
        movieAttributes.each {|key, value| self.send(("#{key}="), value)}
    end

    #class method returns all upcoming movies
    def self.all
        @@all.select {|movie| movie if movie.futureMovie?}
    end

    def self.moviesThisWeek
        date = date_of_next_friday
        moviesInWeek = @@all.select do |movie|
            day = sprintf("%02i", movie.date)
            if @@months[movie.month] == date[0] && day == date[1] && movie.year == date[2]
                movie
            end
        end
        moviesInWeek
    end

    def self.moviesThisMonth
        currentInfo = currentMonthYear
        movieMonth = @@all.select {|movie| movie if movie.month == currentInfo[0] && 
            movie.year == currentInfo[1] && movie.futureMovie?}
        movieMonth
    end

    #class method that checks whether or not the movie release date is in the future
    def futureMovie?
        strDate = @year + "-" + @@months[@month] + "-" + sprintf("%02i", @date)
        newDate = Date.parse(strDate)
        today = Date.today
        result = newDate >= today ? true : false
    end

end