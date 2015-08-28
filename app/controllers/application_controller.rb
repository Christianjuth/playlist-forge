# Setup environment
require "./config/environment"
require 'pry'

# Require models
require "./app/models/user"
require "./app/models/playlist"
require "./app/models/song"

# Set routs
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    # Set the session secret
    set :session_secret, "secret"
  end

  use OmniAuth::Builder do
  provider :spotify, '6b16bf44a25f452db9167a8e616d2555', '321f70c6fee241318147bb4bf6d3d052'
end

  # This function will redirect the user
  # to the login screen (if enabled) when the
  # session[:user_id] is nil else it will
  # pass @user as the current user into the
  # requested view
  before do
    # Force the user to login before using the app
    force_login_page = false
    auth_pages = ["/login","/auth/spotify","/auth/spotify/callback"]
    # Check the session and database for current user
    if !session[:spotify] && !auth_pages.include?(request.path)
      session.destroy
      redirect "/login" if force_login_page
    elsif !auth_pages.include?(request.path)
      @spotify = RSpotify::User.new(session[:spotify])
      @user = User.find_by(spotify_uid: session[:spotify][:uid])
    end
  end

  # This routs the home page to the template
  get "/" do
    redirect "/all-playlists"
  end

  # All playlists
  get "/all-playlists" do
    erb :all_playlists
  end

  # Playlist
  get "/playlist/:id" do
    @playlist = Playlist.find(params[:id])
    @playlist_photo = ""
    first_song = @playlist.songs[0]
    if first_song
      @playlist_photo = RSpotify::Track.find(first_song.spotify_id).album.images[0]["url"]
    end
    erb :playlist
  end

  # This routs the login page to the template
  get "/login" do
    erb :login
  end

  # This rout is triggerd after spotify
  # oauth authenticates
  get '/auth/spotify/callback' do
    @spotify = env["omniauth.auth"]
    session[:spotify] = @spotify
    user = User.find_by(spotify_uid: @spotify[:uid])
    unless user
      user = User.new({
        spotify_uid: @spotify[:uid],
        username: @spotify[:info][:name],
        email: @spotify[:info][:email]
      })
      user.save
    end
    redirect "/all-playlists"
  end


  # -- Spotify actions --

  post "/all-playlists" do
    erb :all_playlists
  end

  post '/create-playlist' do
    playlist = Playlist.new({
      :user_id => @user.id,
      :name => "untitled"
    })
    playlist.save
    redirect "/"
  end

  post "/update-name" do
    id = params[:id]
    playlist = Playlist.find(id)
    playlist.name = params[:name]
    playlist.save
    redirect "/playlist/#{id}"
  end

  post "/add-to-playlist" do
    spotify_song = RSpotify::Track.find(params[:track_id])
    if spotify_song
      song = Song.new({
        name: spotify_song.name,
        album: spotify_song.album.name,
        artist: spotify_song.artists[0].name,
        spotify_id: spotify_song.id,
        playlist_id: params[:playlist_id]
      })
      song.save
    end
    redirect "/playlist/#{params[:playlist_id]}"
  end

  post '/sync-playlist' do
    playlist_id = params[:playlist_id]
    binding.pry
    playlist = User.spotify_uid.create_playlist('#{playlist_id}')
    binding.pry
    tracks = @playlist.songs
      tracks.each do |track|
        track_id = track.spotify_uid
        playlist.add_track('#{track_id}')
        binding.pry
      end
  end

  post '/search-track' do
    @tracks = RSpotify::Track.search(params[:search])
    body(@tracks.to_json)
  end

  post '/search-artist' do
    @artist_search = params[:artist_search]
    @artist_name = RSpotify::Artist.search('#{@artist_search}')
    @albums =@artist_name.ablums
      @albums.each do |album|
        puts album.name
      end
    @album = @albums.name('#{album_name}')
    @ablum = @album.first
    @songs = @ablum.tracks
      @song.each do |song|
        puts song.name
      end
  end


  # -- Helpers --

  # This function takes a class instance and gets
  # it's validation errors parsing them as a string
  def error_messages_for(object)
    all_errors = ""
    for error in object.errors.messages do
      key = error.first.to_s.capitalize
      what_is_wrong = error.second.join(' and ')
      all_errors += "#{key} #{what_is_wrong}.\n"
    end
    all_errors
  end

  # This functin allows you to check if the
  # request is form a form subbmission or ajax
  def request_type?
    return :ajax    if request.xhr?
    return :normal
  end
end