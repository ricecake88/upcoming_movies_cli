require 'date'
require 'time'
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
        puts "Movies coming out this Week"
        movieObject = self.new
        movieObject.name = "Sleepless in Seattle"
        movieObject.description = "Romantic comedy in Seattle"
        movieObject.year = "2018"
        movieObject.month = "May"
        movieObject.date = "25"
        movieObject.url = ""
        #eventually movieObject.actor = [ActorObject1, ActorObject2]
        movieObject.actors = ["Meg Ryan", "Tom Hanks"]
        if self.futureMovie?(movieObject.year, movieObject.month, movieObject.date)
            @@all << movieObject
        end  

        movieObject2 = self.new
        movieObject2.name = "Notting Hill"
        movieObject2.description = "Romantic Comedy in Notting Hill"
        movieObject2.year = "2018"
        movieObject2.month = "June"
        movieObject2.date = "18"
        movieObject2.url = ""
        movieObject2.actors = ["Hugh Grant", "Julia Roberts"]
        if self.futureMovie?(movieObject2.year, movieObject2.month, movieObject2.date)
            @@all << movieObject2
        end        
    end

    #class method to return upcoming movies for the week including today
    def self.week
        @@all
    end

    #class method that returns all upcoming movies for the month
    def self.month
        movieMonths = []
        currentMonth = self.getCurrentMonth
        monthString = @@months.key(currentMonth[0])
        @@all.each do |movie|
            if movie.month == monthString && movie.year == currentMonth[1]
                movieMonths << movie
            end
        end
        movieMonths
    end

    #class method returns all upcoming movies
    def self.all
        @@all
    end

    #class method that checks whether or not the movie release date is in the future
    def self.futureMovie?(year, month, date)
        strDate = year + "-" + @@months[month] + "-" + sprintf("%02i", date)
        newDate = Date.parse(strDate)
        today = Date.today
        if newDate >= today
            puts "Movie is in the future"
            return true
        else
            puts "Movie is old"
            return false
        end        
    end

    def self.getCurrentMonth
        monthNo =  Date.today.strftime("%m")
        currentYear = Date.today.strftime("%Y")
        [monthNo, currentYear]
    end
end