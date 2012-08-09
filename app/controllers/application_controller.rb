require 'recaptcha'

class ApplicationController < ActionController::Base
#  include ReCaptcha::AddHelper


  helper :all

  protect_from_forgery
  before_filter  :set_language
  before_filter :miniprofiler

  # to keep UKA out...
  #  http_basic_authenticate_with :name => "isfit", :password => "betabeta"

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

  def miniprofiler
    if params[:profile] == "yes"
      Rack::MiniProfiler.authorize_request
    end
  end
end
