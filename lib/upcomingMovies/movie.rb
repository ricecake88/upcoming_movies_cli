require 'pry'

class UpcomingMovies::Movie
    extend ::Persons
    attr_accessor :name, :description, :month, :date, :year, :actors, :url
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
        @actors = []
        @@all << self
    end

    def add_actor(name)
#TODO use find_or_create_by_name to check if the Actor already exists in the database
# add it to the movie database of actors.
        if !@actors.include?(name)
            a = Persons::Actor.new(name)               
            self.actors << a
            if !a.movies.include?(self)
                a.movies << self
            end
        end
    end

    #class method returns all upcoming movies
    def self.all
        @@all
    end

end