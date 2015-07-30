class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @config = {
      spaBase: RailsReactRouterExample.spa_base
    }.to_json

    render layout: "application"
  end

  def proxy
    # TODO:
  end
end
