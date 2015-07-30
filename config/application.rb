require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'sprockets'
require 'rack/streaming_proxy'
require 'figaro'
require 'asset_sync'
require 'bootstrap-sass'
require 'sass-rails'
require 'compass-rails'
require 'font-awesome-sass'
require "autoprefixer-rails"
require 'therubyracer'
require 'uglifier'
require 'modernizr-mixin'
require 'sass-json-vars'
require 'browserify-rails'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsReactRouterExample
  class Application < Rails::Application

    # use sass json vars
    config.sass

    # proxy API requests for old IE    
    #config.middleware.use Rack::StreamingProxy::Proxy do |request|
      #if request.path.start_with?("#{RailsReactRouterExample.client_spa_base}proxy")
        #proxy_path = request.path.sub(%r{^#{RailsReactRouterExample.client_spa_base}proxy}, '') + '?' + request.query_string
        #"//#{RailsReactRouterExample.api_url}/api/v1#{proxy_path}"
      #end
    #end

    ## Precompile additional assets.
    config.assets.precompile += %w( head.js deps.css)

    # Common JS
    config.assets.precompile += %w( commonjs.js )
    
    # Polyfills
    config.assets.precompile += %w( polyfills/console-polyfill.js polyfills/es5-sham.js polyfills/es5-shim.js)

    # fonts
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    
    # le node modules
    config.assets.paths << Rails.root.join('node_modules')

    # shims
    config.assets.paths << Rails.root.join('vendor', 'assets', 'javascripts')

    config.assets.initialize_on_precompile = true

    # only files in #{Rails.root}/lib/app/assets/commonjs
    # should be managed by browserify
    config.browserify_rails.paths << lambda { |p| p.start_with?(Rails.root.join("app", "assets", "commonjs").to_s)  }
    config.browserify_rails.paths << Rails.root.join("node_modules").to_s

    # contain node modules within engine
    config.browserify_rails.node_bin = Rails.root.join('node_modules', '.bin')

    # don't use incremental builds for now
    config.browserify_rails.use_browserifyinc = true

    # transform jsx
    config.browserify_rails.commandline_options ||= []
    config.browserify_rails.commandline_options << "-t [ babelify ] --extension=\".js.jsx\""
    config.browserify_rails.commandline_options << '-d'
    config.browserify_rails.commandline_options << '-r commonjs'  
  end

  class << self
    mattr_accessor :spa_base, :asset_host
    self.spa_base   = '/'
    # TODO: asset host
    #self.asset_host = '' 
  end

  # disable ssl in dev
  def self.configure(&block)
    yield self
    if Rails.env == 'development'
      Rails.configuration.action_controller.asset_host = Proc.new { |source, request|
        "http://#{self.asset_host}"
      }
    else
      Rails.configuration.action_controller.asset_host = self.asset_host
    end
  end
end
