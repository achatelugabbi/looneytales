class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :app_setup

  def app_setup
    @token_value = form_authenticity_token()
  end
  protected :app_setup


end
