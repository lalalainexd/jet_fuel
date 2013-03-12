module JetFuel
  class Server < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    set :haml, :format => :html5

    get '/' do
      @urls = Url.all
      haml :index
    end

    post '/create_url' do
      @url = UrlController.create params[:original]
      haml :new_url
    end

    get '/*' do
      short = params[:splat]
      url = UrlController.visit short
      redirect url.original
    end

  end
end
