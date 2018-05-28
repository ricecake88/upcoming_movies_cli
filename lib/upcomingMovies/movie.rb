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
        actor = Persons::Actor.find_or_create_by_name(name)
        if !@actors.detect{|a| a.name=name }
            @actors << actor
            binding.pry
            if !actor.movies.include?(self)
                actor.movies << self
            end
        end
    end

    #class method returns all upcoming movies
    def self.all
        @@all
    end

end