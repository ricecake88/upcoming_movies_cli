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

    def date_of_next_friday
        date  = Date.parse("Friday")
        delta = date > Date.today ? 0 : 7
        [(date + delta).strftime("%m"), (date+delta).strftime("%d"), (date+delta).strftime("%Y")]
    end

    def currentMonthYear
        monthNo =  Date.today.strftime("%m")
        currentYear = Date.today.strftime("%Y")
        monthString = @@months.key(monthNo)
        [monthString, currentYear]
    end

    #class method that checks whether or not the movie release date is in the future
    def futureMovie?(year, month, date)
        strDate = year + "-" + @@months[month] + "-" + sprintf("%02i", date)
        newDate = Date.parse(strDate)
        today = Date.today
        if newDate >= today
            #puts "Movie is in the future"
            return true
        else
            #puts "Movie is old"
            return false
        end        
    end

    def sub_movie_menu
        puts "Select a movie by choosing a number associated with the movie listed."
        input = gets.strip.to_i-1
        #todo - change to raise exception
        if !(input > @movies_week.length || input < 0)
           puts "Movie: #{@movies_week[input].name}"
           puts "Runtime: #{@movies_week[input].runtime}"
        else
            puts "Error"
        end
    end

    def list_movies_week
        @movies_week = []
        date = date_of_next_friday
        UpcomingMovies::Movie.all.each_with_index do |movie,index|
            day = sprintf("%02i", movie.date) 
            if @@months[movie.month] == date[0] && day == date[1] && movie.year == date[2]
                puts "#{index+1} #{movie.month} #{movie.date} #{movie.name}"
                @movies_week << [{:name => movie.name, :runtime=>movie.runtime]
            end
        end
        sub_movie_menu
    end

    def list_movies_month
        currentInfo = currentMonthYear
        UpcomingMovies::Movie.all.each do |movie|
            if movie.month == currentInfo[0] && movie.year == currentInfo[1]
                puts "#{movie.month} #{movie.date} #{movie.name}"
            end
        end
    end

    #todo: refactor list_movies to take no month as default
    # and combine list_movies_month with list_movies
    def list_movies
        UpcomingMovies::Movie.all.each do |movie|
            if futureMovie?(movie.year, movie.month, movie.date)
                puts "#{movie.month} #{movie.date} #{movie.name}"
            end
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
                list_movies_week
            when "m"
                puts "Movies this month"
                list_movies_month
            when "a"
                puts "All upcoming movies"
                list_movies
            when "b"
                puts "All actors with upcoming movies"
                list_actors
            when "d"
                puts "All actors with upcoming movie releases this month"
                list_actors_month
            when "e"
                puts "All actors with upcoming movie releases this week"
                list_actors_week
            when "o"
                puts menu
            when "q"
                puts "Exiting this menu"
            else
                puts "Unrecognizable Command"
            end
        end
    end
end