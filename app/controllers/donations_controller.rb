class DonationsController < ApplicationController
  def donate
  end

  def thank_you
  end

  def ipn_notification
    ipn = PaypalAdaptive::IpnNotification.new
    ipn.send_back(request.raw_post)

    if ipn.verified?
      logger.info "IT WORKED"
    else
      logger.info "IT DIDNT WORK"
    end

    render nothing: true
  end
  
end
