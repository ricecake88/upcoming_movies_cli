require 'pry'

class UpcomingMovies::Movie
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

    #temp class method until scraped
    def self.set_movies
        movieObject = self.new
        movieObject.name = "Sleepless in Seattle"
        movieObject.description = "Romantic comedy in Seattle"
        movieObject.year = "2018"
        movieObject.month = "May"
        movieObject.date = "26"
        movieObject.url = ""
        #eventually movieObject.actor = [ActorObject1, ActorObject2]
        movieObject.actors = ["Meg Ryan", "Tom Hanks"]
            @@all << movieObject

        movieObject2 = self.new
        movieObject2.name = "Notting Hill"
        movieObject2.description = "Romantic Comedy in Notting Hill"
        movieObject2.year = "2018"
        movieObject2.month = "June"
        movieObject2.date = "18"
        movieObject2.url = ""
        movieObject2.actors = ["Hugh Grant", "Julia Roberts"]
           @@all << movieObject2        
    end

    #class method returns all upcoming movies
    def self.all
        @@all
    end

end