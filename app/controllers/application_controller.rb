require 'recaptcha'

class ApplicationController < ActionController::Base
#  include ReCaptcha::AddHelper


  helper :all

  protect_from_forgery
  before_filter  :set_language
  before_filter :miniprofiler

  def set_language
    unless session[:locale]
      country_code = get_country_code_by_id(request.remote_ip)
      if country_code =='no'
        Language.set('no')
        I18n.locale = 'no'
      else
        Language.set('en')
        I18n.locale = 'en'
      end
      session[:locale] = Language.to_s
    end
    Language.set(session[:locale])
    I18n.locale = session[:locale]

    if params[:locale] =~/en|no/
      Language.set(params[:locale])
      I18n.locale = params[:locale]
      session[:locale] = Language.to_s
      redirect_to request.env["HTTP_REFERER"] || root_path
    end
  end

  def get_country_code_by_id(ip)
    begin
      output= IO.popen("whois #{ip} | grep country:")
      output.gets[8..-1].strip.downcase
    rescue
      "en"
    end
  end



  private
  def require_signin!
    if current_user.nil?
      flash[:error] = "You have to be logged in to access this page"
      redirect_to signin_path
    end
  end
  helper_method :require_signing!

  def current_user
    @current_user ||= ApplicantUser.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def miniprofiler
    if params[:profile] == "yes"
      Rack::MiniProfiler.authorize_request
    end
  end
end
