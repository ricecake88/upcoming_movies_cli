require 'date'
require 'time'

class UpcomingMovies::CLI
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

    def call
        root_imdb = "https://www.imdb.com/movies-coming-soon/"
        imdb_url = root_imdb + "2018-06/?ref_=cs_dt_pv"
        s= UpcomingMovies::Scraper.new
        s.scrape_upcoming(imdb_url)        
        # prints out a user menu
        menu
    end

    #class method that checks whether or not the movie release date is in the future
    def futureMovie?(year, month, date)
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

    def list_movies_month
        puts "All upcoming movies playing this month"
        UpcomingMovies::Movie.set_movies
        monthNo =  Date.today.strftime("%m")
        currentYear = Date.today.strftime("%Y")
        monthString = @@months.key(monthNo)
        UpcomingMovies::Movie.all.each do |movie|
            if movie.month == monthString && movie.year == currentYear
                puts "#{movie.month} #{movie.date} #{movie.name}"
            end
        end
    end

    def list_movies
        puts "All Upcoming Movies"
        UpcomingMovies::Movie.set_movies
        UpcomingMovies::Movie.all.each do |movie|
            if futureMovie?(movie.year, movie.month, movie.date)
                puts "#{movie.month} #{movie.date} #{movie.name}"
            end
        end
    end

    def list_actors
        UpcomingMovies::Movie.all.each do |movie|
            if futureMovie?(movie.year, movie.month, movie.date)
                binding.pry
                movie.actors.each do |actor|
                   puts actor
               end
            end
        end
    end

    def menu
        input = nil
        while input != "q"
            puts "--------------------------------------"
            puts "\tUpcoming Movies Menu:"            
            puts "--------------------------------------"
            puts "m. List all movies for the month"
            puts "a. List all movies"
            puts "o. Prints this menu again"
            puts "q: To quit this menu"
            puts "Please select an option: "
            input = gets.strip
            case input
            when "m"
                puts "Movies this upcoming month"
                list_movies_month
            when "a"
                puts "All upcoming movies"
                list_movies
            when "b"
                puts "All actors with upcoming movies"
                list_actors
            when "o"
                puts menu
            when "q"
                puts "Exiting this menu"
            else
                puts "Unrecognizable Command"
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