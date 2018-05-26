class UpcomingMovies::Movie
    attr_accessor :name, :description, :release_date, :actors, :url

    def self.friday
        puts "Movies coming out this Friday"
        movieObject = self.new
        movieObject.name = "Sleepless in Seattle"
        movieObject.description = "Romantic comedy in Seattle"
        movieObject.release_date = "June 8 2001"
        movieObject.url = ""
        #eventually movieObject.actor = [ActorObject1, ActorObject2]
        movieObject.actors = ["Meg Ryan", "Tom Hanks"]

        movieObject2 = self.new
        movieObject2.name = "Notting Hill"
        movieObject2.description = "Romantic Comedy in Notting Hill"
        movieObject2.release_date = "June 8 2001"
        movieObject2.url = ""
        movieObject2.actors = ["Hugh Grant", "Julia Roberts"]

        [movieObject, movieObject2]
    end
end