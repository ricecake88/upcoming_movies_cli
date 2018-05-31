class UpcomingMovies::Person
    attr_accessor :name, :bio, :movies
    def initialize(personAttributes)
        personAttributes.each {|key, value|self.send(("#{key}="), value)}
    end
end