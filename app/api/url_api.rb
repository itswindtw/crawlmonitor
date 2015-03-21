require 'model'

module API
  class UrlAPI < Grape::API
    resources :urls, requirements: { url: /.*/ } do
      params { requires :url, type: String }
      route_param :url do
        before do
          @url = Url.where(url: params[:url]).first
        end

        get do
          error!({ error: params[:url] }, 404) unless @url
          { regions: @url.regions }
        end

        params do
          requires :regions, type: Array do
            requires :index, type: String
            requires :hash, type: String
          end
        end
        post do
          error!({ error: params[:url] }, 405) if @url

          DB.transaction do
            @url = Url.create(url: params[:url])
            params[:regions].each do |r|
              @url.add_region(index: r[:index], hash: r[:hash])
            end
          end

          { regions: @url.regions }
        end

        patch do
        end
      end
    end
  end
end
