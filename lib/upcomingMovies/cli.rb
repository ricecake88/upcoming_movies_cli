require 'date'
require 'time'

class UpcomingMovies::CLI
    extend ::Helper
    extend ::Persons

    def call
        root_imdb = "https://www.imdb.com/movies-coming-soon/"
        imdb_url = root_imdb + "2018-06/?ref_=cs_dt_pv"
        s= UpcomingMovies::Scraper.new
        s.scrape_upcoming(imdb_url)
        #prints out menu    
        menu
    end

    def sub_movie_menu(movie_array)
        puts "Select a movie by choosing a number associated with the movie listed."
        input = gets.strip.to_i-1
        #todo - change to raise exception
        if !(input > movie_array.length-1 || input < 0)
           puts "Movie: #{movie_array[input].name}"
           puts "Runtime: #{movie_array[input].runtime}"
           print "Genre: "
           movie_array[input].genre.each {|g| print g + " "}
           print("\n")
           puts "Description: #{movie_array[input].description}"
           puts "Cast:"
           movie_array[input].actors.each {|actor| puts actor.name}
        else
            puts "Error, no movie associated with specified number."
        end
    end
 
    def list_movies(movie_array)
        if movie_array.length != 0
            movie_array.each_with_index do |movie, index|
                puts "#{index+1}. #{movie.month} #{movie.date} #{movie.name}"
            end
            sub_movie_menu(movie_array)
        else
            puts "There are no upcoming movies for this time frame."
        end
    end

    def sub_actor_menu(actor_array)
        puts "Select an actor to see which upcoming movies the actor has by entering a number:"
        input = gets.strip.to_i-1
        #todo - change to raise exception
        if !(input > actor_array.length-1 || input < 0)
           actor_array[input].movies.each {|movie| puts "#{movie.month} #{movie.date} #{movie.name}"}
        else
            puts "Error, no actor associated with specified number."
        end
    end

    def list_actors(actor_array)
        if actor_array.length != 0
            actor_array.sort! do |x,y|
                x.name <=> y.name
            end
            actor_array.uniq.each_with_index do |actor, index|
                puts "#{index+1}. #{actor.name}"
            end
            sub_actor_menu(actor_array)
        else
            puts "There are no actors with upcoming movie releases in this time frame."
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
            puts "e. List all actors with movies being released this Friday"
            puts "o. Prints this menu again"
            puts "q: To quit this menu"
            puts "Please select an option: "
            input = gets.strip
            case input
            when "w"
                puts "All movies upcoming this Friday"
                puts "----------------------------------------------------"
                list_movies(UpcomingMovies::Movie.movies_this_week)
            when "m"
                puts "Movies being released the rest of this month"
                puts "----------------------------------------------------"                
                list_movies(UpcomingMovies::Movie.movies_this_month)
            when "a"
                puts "All upcoming movies"
                puts "----------------------------------------------------"                
                list_movies(UpcomingMovies::Movie.all)
            when "b"
                puts "All actors with upcoming movies"
                puts "----------------------------------------------------"                
                list_actors(UpcomingMovies::Actor.all.uniq)
            when "d"
                puts "All actors with upcoming movie releases this month"
                puts "----------------------------------------------------"                
                list_actors(UpcomingMovies::Actor.actors_this_month)
            when "e"
                puts "All actors with movie releases this Friday"
                puts "----------------------------------------------------"                
                list_actors(UpcomingMovies::Actor.actors_this_week)
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