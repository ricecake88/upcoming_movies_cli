class UpcomingMovies::Person
    attr_accessor :name, :bio, :movies
    def initialize(name)
        @name = name
    end
end