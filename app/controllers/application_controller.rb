# Setup environment
require "./config/environment"

# Require models
# require "./app/models/"

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
    # Check the session and database for current user
    if (!session[:user_id] || !User.exists?(session[:user_id])) && !["/login","/signup"].include?(request.path)
      session.destroy
      redirect "/login" if force_login_page
    elsif !["/login","/signup"].include?(request.path)
      @user = User.find(session[:user_id])
    end
  end

  # This routs the home page to the template
  get "/" do
    erb :index
  end

  # This routs the signup page to the template
  get "/signup" do
    erb :signup
  end

  post "/signup" do
    user = User.new({
      username: params[:username],
      email:    params[:email],
      hashed_password: params[:password],
    })
    if user.save
      session[:user_id] = user.id
      case request_type?
      when :ajax
        body ({
          success: true,
          message: "success",
          redirect: "/"
        }.to_json)
      else
        redirect "/"
      end
    else
      case request_type?
      when :ajax
        status 500
        body({
          success: false,
          message: error_messages_for(user).to_str
        }.to_json)
      else
        redirect "/"
      end
    end
  end

  # This routs the login page to the template
  get "/login" do
  redirect to("/auth/spotify")
    #erb :login
  end

#   get '/auth/spotify' do

#   end

  get '/auth/spotify/callback' do
    "hello world"
  end


#   post "/login" do
#     @user = User.find_by({username: params[:username]})
#     if @user
#       session[:user_id] = @user.id
#       case request_type?
#       when :ajax
#         body({
#           success: true,
#           message: "success",
#           redirect: "/"
#         }.to_json)
#       else
#         redirect "/"
#       end
#     else
#       case request_type?
#       when :ajax
#         status 500
#         body({
#           success: false,
#           message: "Incorrect username or password"
#         }.to_json)
#       else
#         redirect "/login"
#       end
#     end
#   end


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