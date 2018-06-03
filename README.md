# UpcomingMovies

Version 0.1.0

This program displays the information scraped from "IMDB's Coming Soon" pages, and displays and gathers upcoming movie information. The movie information can then be outputted by movies coming out this Friday, this month or output a list of all movies. In addition, it can display all the actors that have upcoming movies, or by this Friday or by this current month. It can also output movies by an actor via user input.

## Usage

1. Run 'bin/upcomingMovies'
2. This will bring up the program and the menu
```
--------------------------------------
        Upcoming Movies Menu:
--------------------------------------
w. List all movies coming out this Friday
m. List all movies for the month
a. List all movies
e. List all actors with movies being released this Friday
d. List all actors with movies released this month
b. List all actors with upcoming movies
o. Prints this menu again
q: To quit this menu
Please select an option:
```
3. As a user you can choose whether or not you would like to see 
- a list of movies being released this Friday (if the current day is Friday) or those coming up the next Friday if the current day is any day but Friday
- a list of movies being released for the rest of this month
- a list of all the upcoming movies to be released
- a list of actors with movies being released this Friday if today is Friday, or next Friday if today is any other day than Friday.
- a list of actors with movies being released the rest of this month
- a list of all actors with movies being released
4. If you wish to see which movies are being released in a given time frame (options "w", "m", or "a"), you will then be shown a list of those movies.
- Afterward, you will be asked 
a) whether or not you want to view more details on a certain movie by entering the number corresponding to the film
b) whether or not you want to see the list of movies again
or
c) whether or not you want to quit the submenu
5. If you wish to see which actors have upcoming movies to be released in a given time frame (options "e", "d", "b"), you will then be shown a list of those actors.
- Afterward, you will then be asekd
a) whether or not you want to view more details on a certain actor by entering the number corresponding to the actor
b) whether or not you want to see the list of actors again
or
c) whether or not you want to quit the submenu
6. If you choose to see more details of a film, the following information if available will be displayed:
title of the film, runtime, genre(s), a quick summary of the film, and a list of actors that are in the film
7. If you choose to see more details of an actor, only the upcoming movie(s) corresponding to the actor will be displayed. 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Currently, only one test exists.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ricecake88/upcoming_movies_cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UpcomingMovies project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/upcomingMovies/blob/master/CODE_OF_CONDUCT.md).

# upcoming_movies_cli

