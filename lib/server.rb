module JetFuel
  class Server < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    set :haml, :format => :html5

    get '/' do
      response = UrlController.all_sorted_by_visits_and_dates
      @urls_by_visit = response.urls_by_visit
      @urls_by_date = response.urls_by_date
      haml :index
    end

    get '/:short_url' do |short_url|
      response = UrlController.visit short_url
      redirect response.original_url
    end

  end
end
