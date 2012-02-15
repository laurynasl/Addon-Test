class Post < Sequel::Model
  validates_presence_of :title, :body
end
