class People
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :age, Integer
  property :created_at, DateTime

  validates_presence_of :name
end
