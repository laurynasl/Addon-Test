# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
AddonTest::Application.initialize!

=begin
if !defined?(DB)
  DB = Sequel.connect(YAML.load_file(Rails.root + 'config/database.yml')[Rails.env.to_sym])
end
=end
