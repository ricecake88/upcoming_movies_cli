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
        imdb_url = open(url)
        imdbDoc = Nokogiri::HTML(imdb_url)
        titles = imdbDoc.css("div.list.detail h4")

        movie = nil
        titles.each do |node|

            if node.attributes["class"] == nil
                movie = "#{node.text}"
                profile_url = node.children[0].attributes["href"].value
            end

            if profile_url != nil
                movie_attributes = scrape_movie_profile(profile_url)
                m = UpcomingMovies::Movie.new(movie_attributes)
                m.add_attributes({:name=>movie})
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
        
        UpcomingMovies::Movie.all.each do |movie|
          puts "#{movie.name} #{movie.month} #{movie.date}"
        end        
    end

    def scrape_movie_profile(url)
        actors = []
        releaseDate = nil
        month = ""
        date = ""        
        begin
            imdb_html = open(BASE_PATH + url)
            imdbDoc = Nokogiri::HTML(imdb_html)
            actorsInfo = imdbDoc.css("td.itemprop a span")
            release_date = imdbDoc.xpath("//div[contains(@class, title.wrapper)]/a[contains(@title, 'See more release dates')]").text
            dateInfo = release_date.split(" ")
            month = dateInfo[1]
            date = dateInfo[0]
            year = dateInfo[2]
            actorsInfo.each do |actor| 
                actors << UpcomingMovies::Actor.find_or_create_by_name(actor.text)
            end            
        rescue 
            puts "Could not open URL #{BASE_PATH + url}"
        end
        {:actors => actors, :month => month, :date=> date, :year=> year, :url=> url}
    end

    def scrape_distributors(url)
    end
end
