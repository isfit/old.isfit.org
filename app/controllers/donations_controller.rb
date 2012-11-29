require "uri"
require "net/http"

class DonationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def index
    redirect_to page_path(60)
  end

  def donate
    @donation = Donation.new
    redirect_to @donation.paypal_url(thank_you_donations_url, donations_url) 
  end

  def thank_you
    if params[:payment_status] != "Completed"
      redirect_to page_path(60)
    end
  end

  def create
    @exist = Donation.find_by_transaction_number(params[:txn_id])

    if params[:payment_status] == "Completed" && @exist.nil? && verify?(params)
      Donation.create!(:status => params[:payment_status], 
                       :transaction_number => params[:txn_id], 
                       :amount => params[:mc_gross],
                       :name => "#{params[:first_name]} #{params[:last_name]}",
                       :email => params[:payer_email])
      Postoffice.donation("#{params[:first_name]} #{params[:last_name]}", params[:payer_email]).deliver!
    end
   
    render :nothing => true
  end

  private

  def verify?(params)
    paypal_uri = URI.parse("https://www.paypal.com/cgi-bin/webscr")
    http = Net::HTTP.new(paypal_uri.host, paypal_uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(paypal_uri.request_uri)
    request.set_form_data(params.merge("cmd" => "_notify-validate"))
    response = http.request(request)

    if response.body == "VERIFIED"
      true
    else
      false
    end
  end

end
