require 'nokogiri'
require 'open-uri'

class UpcomingMovies::Scraper
    def initialize
        puts "test"
    end

    @@actors = ["Tom Hanks", "Tom Cruise", "Nicole Kidman", "Rachel McAdams"]
    # first version is to scrape coming soon information
    # second version is to take information from coming soon and
    # get info from movie profile page
    def scrape_upcoming(url)
        #root_imdb = "https://www.imdb.com/movies-coming-soon/"
        #imdb_html = open(root_imdb + "2018-06/?ref_=cs_dt_pv")
        imdb_url = open(url)
        imdbDoc = Nokogiri::HTML(imdb_url)
        #imdbDoc = Nokogiri::HTML(imdb_html)
        titles = imdbDoc.css("div.list.detail h4")
        actors = imdbDoc.xpath("//div[@class='txt-block']/span[@itemprop='actors']/a/text()")

        releaseDate = nil
        month = ""
        date = ""
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
          if releaseDate != nil && movie != nil 
            m = UpcomingMovies::Movie.new({:name=>movie, :month=>month, :date=>date, :year=>"2018" })
            @@actors.each do |name|
                m.add_actor(name)
            end
            break
          end
        end
        
        UpcomingMovies::Movie.all.each do |movie|
          puts "#{movie.name} #{movie.month} #{movie.date}"
        end        
    end

    # add actor information to actor
    def scrape_profile(url)
        
    end

    def scrape_distributors(url)
    end
end
