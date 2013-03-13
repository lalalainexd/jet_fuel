module JetFuel
  class Server < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    set :haml, :format => :html5

    get '/' do
      response = UrlController.all_sorted_by_visits
      @urls = response.urls
      haml :index
    end

    post '/create_url' do
      response = UrlController.shorten params[:originalUrl]
      @url = response.short_url
      haml :new_url
    end

    get '/:short_url' do |short_url|
      response = UrlController.visit short_url
      redirect response.original_url
    end



  end
end
