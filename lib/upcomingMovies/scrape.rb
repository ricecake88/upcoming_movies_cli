require 'nokogiri'
require 'open-uri'

#Scraper -> Movies -> Actors 
class UpcomingMovies::Scraper

    BASE_PATH = "https://imdb.com/"
    def scrape_base(url)
        puts "Please wait a few minutes, retrieving data..."
        main_url = open(url)
        imdbDoc = Nokogiri::HTML(main_url)
        all_pages = imdbDoc.css("div.header div div.sort option")
        all_pages.each do |page_url|
            new_url = open(BASE_PATH + page_url.attribute("value").value)
            puts "Getting Page..."
            scrape_upcoming(Nokogiri::HTML(new_url))
        end
    end

    def scrape_upcoming(document)
        titles = document.css("div.list.detail h4")
        descriptions = document.css("tr div.outline")

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
                m.add_self_to_actor
                puts "...Scraped #{m.name}"
            end
        end

        descriptions.each_with_index do |description, index|
            UpcomingMovies::Movie.all[index].add_attributes({:description=>description.text.strip})
        end

    end

    def scrape_movie_profile(url)
        actors = []
        genres = []
        releaseDate = nil
        month = ""
        date = ""        
        begin
            imdb_html = open(BASE_PATH + url)
            imdbDoc = Nokogiri::HTML(imdb_html)
            actorsInfo = imdbDoc.css("td.itemprop a span")
            runtime = imdbDoc.css("div.txt-block time").text
            genreInfo = imdbDoc.css("div.title_wrapper div.subtext a span")
            genreInfo.each {|genre| genres << genre.text }
            rating = imdbDoc.css("div.subtext meta").attribute("content").value
            #description = imdbDoc.css("div.summary_text").text.strip
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
        {:actors => actors, :month => month, :date=> date, :year=> year, :url=> url, 
            :runtime=> runtime, :genre=>genres, :rating=>rating}
    end

    def scrape_distributors(url)
    end
end
