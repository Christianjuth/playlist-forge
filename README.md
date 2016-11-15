# Playlist Forger
Durning the summer of 2016, I took a two-week course at the Flatiron School. The goal of the course was to take high schoolers with experience in front-end coding - like me -  and teach us how to build Sinatra apps. Durning the entire program, I build three or four working projects. At the end of the program, they divided us up into teams and challenged us to plan, design, and build working web apps. My team and I went back and forth on a few ideas, but we finally settled on a tool to manage Spotify Playlists. At the time, Spotify did not offer song suggestions for user created playlists. I often found myself not sure what songs would fit the theme of the playlist I was creating. The solution: Playlist Forge. Playlist Forge took this idea and made it a reality. Users would log in with their Spotify account, create a playlist, get song suggests based on other songs in the playlist, and export their playlist back to Spotify. The idea seemed simple enough, but we had been using Sinatra for less than two weeks, and none of us had any experience with APIs. We had less than 48 hours to design, build, and present our app to the rest of the class. The project came together like clockwork in the end, and we finished with no time to spare. If it were not for out teamwork and trusting one another, there is no way we could have pulled it off. [Playlist Forge is still functional](https://playlist-forge.herokuapp.com/login) but in demo form and is not a final product. Spotify recent added this idea to their own application, so I can proudly say that we designed a feature Spotify adopted.

# Getting Started
Clone the repository

### Setup environment
Requirements
* [Ruby v2 and Rubygems](https://rvm.io/) _(via RVM recommended)_
* [Bundler](http://bundler.io/)
* [NodeJS & NPM](https://nodejs.org/en/)
* [GruntJS](http://gruntjs.com)
* [Bower](http://bower.io/)

```shell
  # install node modules and gems
  npm install
```
_This command runs `bundle install` so you do not have to run that yourself._

### Running Sinatra
```shell
  # this command starts shotgun on port 3000
  npm start

  # this command force stops shotgun
  npm stop
```

### Database
```shell
  # migrate database
  npm run migrate
```

### Compiling
```shell
  # Compile once
  npm run compile

  # Continious compiling
  npm develop
```
