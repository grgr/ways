require 'rails/generators/base'

class WaysGenerator < Rails::Generators::NamedBase
  desc "This generator creates an initializer either for vbb or hvv at config/initializers"

  source_root File.expand_path("../templates", __FILE__)

  def copy_initializer_file
    copy_file "#{name}.rb", "config/initializers/ways.rb"
  end

end
