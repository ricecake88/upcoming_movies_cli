require 'date'
require 'time'

class UpcomingMovies::CLI
    include ::Helper

    def call
        root_imdb = "https://www.imdb.com/movies-coming-soon/"
        imdb_url = root_imdb + "2018-06/?ref_=cs_dt_pv"
        s= UpcomingMovies::Scraper.new
        s.scrape_upcoming(imdb_url)        
        # prints out a user menu
        menu
    end

    def sub_movie_menu(movieArray)
        puts "Select a movie by choosing a number associated with the movie listed."
        input = gets.strip.to_i-1
        #todo - change to raise exception
        if !(input > movieArray.length-1 || input < 0)
           puts "Movie: #{movieArray[input].name}"
           puts "Runtime: #{movieArray[input].runtime}"
           print "Genre: "
           movieArray[input].genre.each {|g| print g + " "}
           print("\n")
           puts "Description: #{movieArray[input].description}"
           puts "Cast:"
           movieArray[input].actors.each {|actor| puts actor.name}
        else
            puts "Error, no movie associated with specified number."
        end
    end
 
    def list_movies(movieArray)
        if movieArray.length != 0
            movieArray.each_with_index do |movie, index|
                puts "#{index+1} #{movie.month} #{movie.date} #{movie.name}"
            end
            sub_movie_menu(movieArray)
        else
            puts "There are no upcoming movies for this time frame."
        end
    end

    def list_actors
        UpcomingMovies::Actor.all.sort! do |x,y|
            x.name <=> y.name
        end
        UpcomingMovies::Actor.all.each {|actor| puts actor.name}
    end

    def list_actors_month
        currentInfo = currentMonthYear
        UpcomingMovies::Movie.all.each do |movie|
            if movie.month == currentInfo[0] && movie.year == currentInfo[1]
                movie.actors.each {|actor| puts actor.name}
            end
        end
    end

    def list_actors_week
        date = date_of_next_friday
        UpcomingMovies::Movie.all.each_with_index do |movie,index|
            day = sprintf("%02i", movie.date) 
            if @@months[movie.month] == date[0] && day == date[1] && movie.year == date[2]
                movie.actors.each {|actor| puts actor.name}
            end
        end
    end

    def menu
        input = nil
        while input != "q"
            puts "--------------------------------------"
            puts "\tUpcoming Movies Menu:"            
            puts "--------------------------------------"
            puts "w. List all movies coming out this Friday"
            puts "m. List all movies for the month"
            puts "a. List all movies"
            puts "b. List all actors with upcoming movies"
            puts "d. List all actors with movies released this month"
            puts "e. List all actors with movies being released this week"
            puts "o. Prints this menu again"
            puts "q: To quit this menu"
            puts "Please select an option: "
            input = gets.strip
            case input
            when "w"
                puts "All movies upcoming this Friday"
                puts "----------------------------------------------------"
                list_movies(UpcomingMovies::Movie.moviesThisWeek)
            when "m"
                puts "Movies being released the rest of this month"
                puts "----------------------------------------------------"                
                list_movies(UpcomingMovies::Movie.moviesThisMonth)
            when "a"
                puts "All upcoming movies"
                puts "----------------------------------------------------"                
                list_movies(UpcomingMovies::Movie.all)
            when "b"
                puts "All actors with upcoming movies"
                puts "----------------------------------------------------"                
                list_actors
            when "d"
                puts "All actors with upcoming movie releases this month"
                puts "----------------------------------------------------"                
                list_actors_month
            when "e"
                puts "All actors with upcoming movie releases this week"
                puts "----------------------------------------------------"                
                list_actors_week
            when "o"
                puts menu
            when "q"
                puts "Exiting this menu"
            else
                puts "Don't recognize that command. Try again."
            end
        end
    end
end