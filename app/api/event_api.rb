require 'model'

module API
  class EventAPI < Grape::API
    PAGING_COUNT = 10

    resources :events do
      params do
        optional :start_at, type: Integer
      end
      get do
        last_record_id = Event.last.id

        events = if params[:start_at]
          Event.where('id > ?', params[:start_at])
               .limit(PAGING_COUNT)
               .all.reverse
        else
          Event.order(Sequel.desc(:id))
               .limit(PAGING_COUNT)
               .all
        end

        paging = {}
        unless events.empty?
          paging[:start] = events.last.id
          paging[:end]   = events.first.id
          paging[:last]  = last_record_id
        end

        { data: events, paging: paging }
      end
    end
  end
end
