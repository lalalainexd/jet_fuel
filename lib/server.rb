module JetFuel
  class Server < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    set :haml, :format => :html5
    set :sessions, true
    set :session_secret, 'super secret'

    get '/' do
      response = UrlController.all_sorted_by_visits_and_dates
      @urls_by_visit = response.urls_by_visit
      @urls_by_date = response.urls_by_date
      haml :index
    end

    get '/users/:username' do |username|
      response = AnalyticsController.analysis_for_user username
      @user = response.user
      haml :url_stats
    end

    post '/create_url/:username' do |username|
      original = params[:originalUrl]
      vanity = params[:vanity]
      @user = User.find_by_username username
      response = UrlController.shorten_with_vanity @user, original, vanity
      haml :url_stats
    end

    post '/create_url' do
      response = UrlController.shorten params[:originalUrl]
      @url = response.short_url
      haml :new_url
    end

    post '/register' do
      username = params[:username]
      pw1 = params[:password1]
      pw2 = params[:password2]
      response = RegistrationController.register(username, pw1, pw2)
      if response.success?
        params[:password] = pw1
        redirect '/login', 307
      else
        redirect '/register'
      end
    end

    post '/login' do
      username = params[:username]
      pw = params[:password]
      can_login?(username, pw) ? redirect(login(username)) : redirect('/login')
    end

    get '/login' do
      haml :login_form, {layout: false}
    end

    get '/register' do
      haml :register_form, {layout: false}
    end

    get '/:short_url' do |short_url|
      response = UrlController.visit short_url
      redirect response.original_url
    end

    def authorized? username
      LoginController.logged_in? username, session[:user_id]
    end

    def can_login? username, password
      !LoginController.can_login?(username, password).cookie.nil?
    end

    def cookie username, password
      LoginController.can_login?(username, password).cookie
    end

    def login username
      set_session(cookie(usename))
      "/users/#{username}"
    end

    def set_session user_cookie
      session[:user_id] = user_cookie
    end

    def end_session
      session[:user_id] = nil
    end
  end
end
