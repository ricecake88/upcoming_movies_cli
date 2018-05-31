require 'pry'

class UpcomingMovies::Movie
    extend ::Persons
    attr_accessor :name, :description, :month, :date, :year, :actors, :url, :runtime
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
        @@all
    end

end