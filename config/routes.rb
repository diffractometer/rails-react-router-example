Rails.application.routes.draw do

  root 'application#index'

  get "/*path" => redirect{|params, request|
    redirect_path(request.host_with_port, params[:path])
  }



  def redirect_path(host, target_path)
    (
      redirect_protocol + 
      host + 
      RailsReactRouterExample.spa_base + 
      "#/" + 
      target_path
    )
  end

  def redirect_protocol
    case Rails.env
    when 'development', 'test'
      'http://'
    else
      'https://'
    end
  end
end
