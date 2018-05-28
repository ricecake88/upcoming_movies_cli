class Person
    attr_accessor :name, :bio, :movies
    def initialize(name)
        @name = name
        @movies = []
    end
end