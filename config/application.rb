require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GithubMeishiGenerator
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework false
    end

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
