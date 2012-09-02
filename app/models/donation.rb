class Donation < ActiveRecord::Base
  def paypal_url(return_url, notify_url)
    values = {
      :hosted_button_id => 'P898G78SELH86',
      :cmd => '_s-xclick',
      :return => return_url,
      :notify_url => notify_url
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
