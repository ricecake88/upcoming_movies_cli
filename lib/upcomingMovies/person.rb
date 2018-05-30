class UpcomingMovies::Person
    attr_accessor :name, :bio, :movies
    def initialize(personAttributes)
        personAttributes.each do |key, value|
        #    if key != :movies
                self.send(("#{key}="), value)
         #   end
        end
       # @movies = []
    end
end