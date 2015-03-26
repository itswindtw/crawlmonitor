require 'model'
require 'cgi'

module API
  class UrlAPI < Grape::API
    resources :urls, requirements: { url: /.*/ } do
      params { requires :url, type: String }
      route_param :url do
        before do
          @url = Url.where(url: CGI.unescape(params[:url])).first
        end

        get do
          error!({ error: params[:url] }, 404) unless @url
          { regions: @url.regions }
        end

        params do
          requires :regions, type: Array do
            requires :index, type: String
            requires :hash_val, type: String
          end
        end
        put do
          error!({ error: params[:url] }, 400) if params[:regions].empty?
          status 201 unless @url

          @url ||= Url.create(url: params[:url])

          DB.transaction do
            params[:regions].each do |pr|
              r = Region.where(url: @url, index: pr[:index]).first
              if r
                r.update(hash_val: pr[:hash_val]) unless r.hash_val == pr[:hash_val]
              else
                @url.add_region(index: pr[:index], hash_val: pr[:hash_val])
              end
            end
          end

          { regions: @url.regions }
        end
      end
    end
  end
end
