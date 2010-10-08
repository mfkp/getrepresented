require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Getrepresented
  class Application < Rails::Application
    config.time_zone = 'UTC'
    
    config.filter_parameters += [:password]
    
    Rails.application.config.secret_token = '091ebe1a403421884b0f3f231ae2318eb2621742148854caaf854c1f2c2188c4dcc2dcf682b40e0e943985d4a70ba2a39a8977d11ca4f0a6116c51bed6eab69f'
  end
end
