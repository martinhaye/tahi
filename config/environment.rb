# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Tahi::Application.initialize!

Mime::Type.register "application/epub+zip", :epub
