class Contact < ActiveRecord::Base
  belongs_to :country

  cattr_reader :per_page
  @@per_page = 20

  validates_presence_of :first_name, :message => "First name can't be blank"
  validates_presence_of :last_name, :message => "Last name can't be blank"
end
