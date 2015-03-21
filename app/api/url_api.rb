module API
  class UrlAPI < Grape::API
    get 'hello' do
      { 'Hello' => 'Rack' }
    end
  end
end
