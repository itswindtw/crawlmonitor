require 'model'

module API
  class EventAPI < Grape::API
    PAGING_COUNT = 200 

    resources :events do
      params do
        optional :start_at, type: Integer
      end
      get do
        events = if params[:start_at]
          Event.where('id > ?', params[:start_at])
               .limit(PAGING_COUNT)
               .all.reverse
        else
          Event.order(Sequel.desc(:id))
               .limit(PAGING_COUNT)
               .all
        end

        paging = { last: 0 }
        paging[:last] = Event.last.id if Event.last

        unless events.empty?
          paging[:start] = events.last.id
          paging[:end]   = events.first.id
        end

        { data: events, paging: paging }
      end
    end
  end
end
