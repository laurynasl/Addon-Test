class PostMigration < Sequel::Migration

  def up
    create_table :posts do
      primary_key :id
      text :title, :null => false
      text :body, :null => false
      varchar :ip_address, :null => false

      timestamp :created_at, :null => false, :default => 'now()'.lit
      timestamp :updated_at, :null => false, :default => 'now()'.lit
    end
  end

  def down
    drop_table :posts
  end


end
