class UpcomingMovies::CLI
    def call
        # prints out a user menu
        menu
    end

    #list upcoming movies
    def list_movies_week
        puts "All upcoming movies playing this week"
        UpcomingMovies::Movie.set_movies
        movies = UpcomingMovies::Movie.week
        movies.each do |movie|
            puts "#{movie.month} #{movie.date} #{movie.name}"
        end
    end

    def list_movies_month
        puts "All upcoming movies playing this month"
        UpcomingMovies::Movie.set_movies
        movies = UpcomingMovies::Movie.month
        movies.each do |movie|
            puts "#{movie.month} #{movie.date} #{movie.name}"
        end
    end

    def list_movies
        puts "All Upcoming Movies"
        UpcomingMovies::Movie.set_movies
        movies = UpcomingMovies::Movie.all
        movies.each do |movie|
            puts "#{movie.month} #{movie.date} #{movie.name}"
        end
    end

    def menu
        input = nil
        while input != "q"
            puts "--------------------------------------"
            puts "\tUpcoming Movies Menu:"            
            puts "--------------------------------------"
            puts "u. List all movies for this upcoming week"
            puts "m. List all movies for the month"
            puts "a. List all movies"
            puts "o. Prints this menu again"
            puts "q: To quit this menu"
            puts "Please select an option: "
            input = gets.strip
            case input
            when "u"
                puts "Movies this upcoming Friday"
                list_movies_week
            when "m"
                puts "Movies this upcoming month"
                list_movies_month
            when "a"
                puts "All upcoming movies"
                list_movies
            when "o"
                puts menu
            when "q"
                puts "Exiting this menu"
            else
                puts "blah"
            end
            # default list of options for a menu
            # if 1 - list all movies for upcoming week
            # if 2 - list all movies for the month
            # if 3 - list all movies for the rest of the year
            # if 4 - list all actors that have upcoming movies for the year
                # pick an acctor to show the list of movies being released
                # for that actor
            # if 5 - list all distributors that have upcoming movies for the year
                # pick a distributor to show list of movies being released related
                # to distributor
        end
    end
end