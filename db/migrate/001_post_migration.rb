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

    #self << "CREATE LANGUAGE plpgsql"
    self << File.read('db/triggers/posts.updated_at.sql')
  end

  def down
    drop_table :posts
    #self << "DROP function set_updated_at"
    #self << "DROP LANGUAGE plpgsql CASCADE"
  end


end
