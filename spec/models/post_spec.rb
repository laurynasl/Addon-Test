require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Post do
  before(:each) do
    hornsby_scenario
    @post = Post.new(
      :title => 'title',
      :body => 'body',
      :ip_address => '127.0.0.1'
    )
  end

  it "should be valid" do
    @post.save
    puts 'post was saved'
  end
end
