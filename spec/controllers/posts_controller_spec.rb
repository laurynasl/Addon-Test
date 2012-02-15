require 'spec_helper'

describe PostsController, "routes" do
  it "should route" do
    {:get => "/"}.should route_to(:controller => "posts", :action => "index")
    {:get => "/posts"}.should route_to(:controller => "posts", :action => "index")
    {:post => "/posts"}.should route_to(:controller => "posts", :action => "create")
  end
end

describe PostsController, "INDEX" do
  it "should list" do
    hornsby_scenario :post
    get :index
    assigns(:posts).should == [@post]
    response.should be_success
  end
end

describe PostsController, "NEW" do
  it "should display creation form" do
    hornsby_scenario
    get :new
    response.should be_success
  end
end

describe PostsController, "CREATE" do
  it "should display creation form" do
    hornsby_scenario
    post :create, :post => {
      :title => 'title',
      :body => 'body'
    }
    post = assigns(:post)
    post.id.should_not == nil
    post.title.should == 'title'
    post.body.should == 'body'
    post.ip_address.should == '0.0.0.0'
    response.should redirect_to(root_path)
  end

  it "should render form again on validation failure" do
    hornsby_scenario
    post :create, :post => {
      :title => '',
      :body => 'body'
    }
    post = assigns(:post)
    post.id.should == nil
    response.should be_success
  end
end

describe PostsController, "EDIT" do
  it "should display edit form" do
    hornsby_scenario :post
    get :edit, :id => @post.id
    response.should be_success
  end

  it "should fail because of different ip address" do
    hornsby_scenario :post
    @post.update(:ip_address => '0.0.0.1')
    get :edit, :id => @post.id
    response.code.should == "403"
  end

  it "should fail because of not existing post" do
    hornsby_scenario
    get :edit, :id => 1
    response.code.should == "404"
  end
end

describe PostsController, "UPDATE" do
  it "should update" do
    hornsby_scenario :post
    put :update, :id => @post.id, :post => {
      :title => 'h1',
      :body => 'text'
    }
    response.should redirect_to(root_path)
    @post.reload
    @post.title.should == 'h1'
    @post.body.should == 'text'
  end

  it "should render form again on validation failure" do
    hornsby_scenario :post
    put :update, :id => @post.id, :post => {
      :title => '',
      :body => 'text'
    }
    response.should be_success
  end
end
