require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Angry
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
      puts html_tag
      if html_tag =~ /class="(.*?)"/
        (html_tag.sub /class="(.*?)"/, 'class="\1 is-invalid"').html_safe
      else
        (html_tag.sub /(\/>|>)/, 'class="is-invalid" \1').html_safe
      end
    end
  end
end
