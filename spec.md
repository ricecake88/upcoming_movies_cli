# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
- [x] Pull data from an external source

My program pulls data from the "Coming Soon" page from IMDB:
https://www.imdb.com/movies-coming-soon/?ref_=nv_mv_cs_4

and then gets the profile page of each movie listed. For example:
Ocean's Eleven:
https://www.imdb.com/title/tt5164214/?ref_=cs_ov_i

From there, it scrapes the parental guidance rating, the runtime
the genres, the release date, the summary, and the cast.

It stores the cast each in its own class.

- [x] Implement both list and detail views

My program brings up a menu that 
a) prints out a list of movies in different configurations (this month,
    this Friday, all - though it doesn't print all, as it would take too long
    in its current state, but would be easy enough to add all the other 
    Coming Soon pages from IMDB)
b) gives the user an option to list more information on a movie
c) prints out a list of actors in different configurations (with movies
    coming out this Friday, this month, and all available)
d) gives the user an option to choose an actor to see which movies they
    have that are coming out in the future for each perspective configuration.