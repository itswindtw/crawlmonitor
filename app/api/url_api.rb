require 'model'

module API
  class UrlAPI < Grape::API
    resources :urls do
      params { requires :url, type: String }

      route_param :url do
        get do
          url = Url.where(url: params[:url]).first
          error!({ error: params[:url] }, 404) unless url

          { regions: url.regions }
        end

        post do
        end

        patch do
        end
      end
    end
  end
end
