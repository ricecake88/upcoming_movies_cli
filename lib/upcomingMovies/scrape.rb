require 'nokogiri'
require 'open-uri'

#Scraper -> Movies -> Actors 
class UpcomingMovies::Scraper

    BASE_PATH = "https://imdb.com/"
    @@actors = ["Tom Hanks", "Tom Cruise", "Nicole Kidman", "Rachel McAdams", "Tom Hanks"]
    # first version is to scrape coming soon information
    # second version is to take information from coming soon and
    # get info from movie profile page
    def scrape_upcoming(url)
        puts "Please wait a few minutes, retrieving data..."
        #root_imdb = "https://www.imdb.com/movies-coming-soon/"
        #imdb_html = open(root_imdb + "2018-06/?ref_=cs_dt_pv")
        imdb_url = open(url)
        imdbDoc = Nokogiri::HTML(imdb_url)
        #imdbDoc = Nokogiri::HTML(imdb_html)
        titles = imdbDoc.css("div.list.detail h4")


        releaseDate = nil
        month = ""
        date = ""
        movie = nil
        titles.each do |node|

            if node.attributes["class"] == nil
                movie = "#{node.text}"
                profile_url = node.children[0].attributes["href"].value
        
            elsif node.attributes["class"].value == "li_group"
                releaseDate = "#{node.text}"
                dateInfo = releaseDate.split(" ")
                month = dateInfo[0]
                date = dateInfo[1].gsub(/\u00A0/, "")
            end
           # binding.pry
          if releaseDate != nil && movie != nil && profile_url != nil
            m = UpcomingMovies::Movie.new({:name=>movie, :month=>month, :date=>date,
                 :year=>"2018", :url=>profile_url })
            movie_attributes = scrape_movie_profile(profile_url, m)
            m.add_attributes(movie_attributes) #is this the best place for this?
            if m.actors
                m.actors.each do |actor|
                    if actor.movies
                        if !actor.movies.any?{|movie| movie.name == m.name}
                            actor.instance_variable_set(:@movies, [m])
                        end
                    else
                        actor.instance_variable_set(:@movies, [m])
                    end
                end
            end
          end
        end
        
        #UpcomingMovies::Movie.all.each do |movie|
        #  puts "#{movie.name} #{movie.month} #{movie.date}"
        #end        
    end

    # add actor information to actor
    def scrape_movie_profile(url, movieInstance)
        actors = []
        begin
            imdb_html = open(BASE_PATH + url)
            imdbDoc = Nokogiri::HTML(imdb_html)
            actorsInfo = imdbDoc.css("td.itemprop a span")
            actorsInfo.each do |actor| 
                actors << UpcomingMovies::Actor.find_or_create_by_name(actor.text)
            end            
        rescue 
            puts "Could not open URL #{BASE_PATH + url} for #{movieInstance.name}"
        end
        {:actors => actors}
    end

    def scrape_distributors(url)
    end
end
