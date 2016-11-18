require 'rails/generators/base'

class WaysGenerator < Rails::Generators::Base
  desc "This generator creates an initializer file at config/initializers"

  source_root File.expand_path("../templates", __FILE__)

  def copy_initializer_file
    copy_file "initializer.rb", "config/initializers/ways.rb"
  end

end
