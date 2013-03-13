module JetFuel
  class Server < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    set :haml, :format => :html5

    get '/' do
      @urls = Url.all
      haml :index
    end

    post '/create_url' do
      response = UrlController.shorten params[:originalUrl]
      @url = response.short_url
      haml :new_url
    end

    get '/la/:short_url' do |short_url|
      puts params.inspect
      puts short_url
      response = UrlController.visit short_url
      redirect response.original_url
    end


  end
end
