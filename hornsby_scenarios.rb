# for more information, see http://github.com/laurynasl/hornsby/wikis/usage
scenario :post do
  @post = Post.create(
    :title => 'title',
    :body => 'body',
    :ip_address => '0.0.0.0'
  )
end
