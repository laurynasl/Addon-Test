class Post < Sequel::Model
  include Sequel::Timestamps

  validates_presence_of :title, :body
end
