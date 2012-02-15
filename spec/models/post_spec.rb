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
  end

  it "should require title" do
    @post.title = nil
    @post.should_not be_valid
  end

  it "should require body" do
    @post.body = nil
    @post.should_not be_valid
  end
end
