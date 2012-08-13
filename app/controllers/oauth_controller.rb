class OauthController < ApplicationController

  def start
    facebook_settings = YAML::load(File.open("#{Rails.root}/config/oauth.yml"))
    redirect_to client(facebook_settings).authorize_url(client_id: facebook_settings[Rails.env]['application_id'],redirect_uri: oauth_callback_url)
  end

  def callback
    facebook_settings = YAML::load(File.open("#{Rails.root}/config/oauth.yml"))
    # access_token = client(facebook_settings).auth_code.get_token(params[:code], {client_id: facebook_settings[Rails.env]['application_id'], client_secret: facebook_settings[Rails.env]['secret_key'],redirect_uri: oauth_callback_url})
    # DO IT YOURSELF
    url = URI.parse("https://graph.facebook.com/oauth/access_token?client_id=#{facebook_settings[Rails.env]['application_id']}&redirect_uri=#{oauth_callback_url}&client_secret=#{facebook_settings[Rails.env]['secret_key']}&code=#{params[:code]}")
    require 'open-uri'
    open(url) do |https|
      @respons = https.read
    end

    facebook_token = @respons.split('&')[0].split("=").last


    newurl = URI.parse('https://graph.facebook.com/me?access_token=' + facebook_token)
    puts newurl
    open(newurl) do |https|
      @facebookme = JSON.parse(https.read)
    end

    @user = OauthUser.find_or_create_by_facebook_id(@facebookme['id'])
    @user.token = facebook_token
    @user.name = @facebookme['name']
    @user.save!

    session[:user] = @user
    redirect_to root_path
  end

  protected

  def client(facebook_settings)
    @client ||= OAuth2::Client.new("#{facebook_settings[Rails.env]['application_id']}", "#{facebook_settings[Rails.env]['secret_key']}", :site => 'https://graph.facebook.com')
    return @client
  end
end
