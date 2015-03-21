class Url < Sequel::Model
  one_to_many :regions
end

class Region < Sequel::Model
  many_to_one :url
end
