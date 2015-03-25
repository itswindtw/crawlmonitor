class Url < Sequel::Model
  one_to_many :regions
end

class Region < Sequel::Model
  many_to_one :url

  def after_create
    super
    Event.create(url: url.url, index: index, hash_val: hash_val)
  end

  def after_update
    super
    Event.create(url: url.url, index: index, hash_val: hash_val)
  end
end

class Event < Sequel::Model
end
