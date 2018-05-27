require 'nokogiri'
require 'open-uri'

class UpcomingMovies::Scraper
    def initialize
        puts "test"
    end
    def scrape_upcoming(url)
        #root_imdb = "https://www.imdb.com/movies-coming-soon/"
        #imdb_html = open(root_imdb + "2018-06/?ref_=cs_dt_pv")
        imdb_url = open(url)
        imdbDoc = Nokogiri::HTML(imdb_url)
        #imdbDoc = Nokogiri::HTML(imdb_html)
        titles = imdbDoc.css("div.list.detail h4")

        releaseDate = nil
        month = ""
        date = ""
        titles.each do |node|
            if node.attributes["class"] == nil
                movie = "#{node.text}"
            elsif node.attributes["class"].value == "li_group"
                releaseDate = "#{node.text}"
                dateInfo = releaseDate.split(" ")
                month = dateInfo[0]
                date = dateInfo[1].gsub(/\u00A0/, "")
            end
          if releaseDate != nil && movie != nil 
            UpcomingMovies::Movie.new({:name=>movie, :month=>month, :date=>date, :year=>"2018" })
          end
        end
        
        UpcomingMovies::Movie.all.each do |movie|
          puts "#{movie.name} #{movie.month} #{movie.date}"
        end        
    end

    def scrape_profile(url)
        actor1 = Actor.create_from_name("Tom Hanks")
        actor2 = Actor.create_from_name("Meg Ryan")
    end

    def scrape_distributors(url)
    end
end
