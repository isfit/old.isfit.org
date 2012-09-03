class Donation < ActiveRecord::Base
  def paypal_url(return_url, notify_url)
    values = {
      :hosted_button_id => '2ELUQS6A2KTTS',
      :cmd => '_s-xclick',
      :return => return_url,
      :notify_url => notify_url
    }
    "https://www.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
