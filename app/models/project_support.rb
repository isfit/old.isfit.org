class ProjectSupport < ActiveRecord::Base
  belongs_to :country
  belongs_to :workshop

  validates :person_name, :presence => true
  validates :person_age, :presence => true
  validates :person_mail, :presence => true
  validates :person_association, :presence => true
  validates :group_description, :presence => true
  validates :project_description, :presence => true
  validates :funds_description, :presence => true

  validate :country_id_value
  validate :person_age_value

  validates_length_of :person_name, :maximum => 100, :too_long => "%{count} characters is the maximum allowed"
  validates_length_of :person_mail, :maximum => 100, :too_long => "%{count} characters is the maximum allowed"
  validates_length_of :person_association, :maximum => 100, :too_long => "%{count} characters is the maximum allowed"
  validates_length_of :group_description, :maximum => 1000, :too_long => "%{count} characters is the maximum allowed"
  validates_length_of :project_description, :maximum => 2000, :too_long => "%{count} characters is the maximum allowed"
  validates_length_of :funds_description, :maximum => 1000, :too_long => "%{count} characters is the maximum allowed"

  def country_id_value
    if self.country_id == nil or self.country_id < 1
      self.errors.add_to_base("Country must be chosen.")
    end
  end

  def person_age_value
    if self.person_age == nil or !(self.person_age > 0 and self.person_age < 100)
      self.errors.add_to_base("Person age is not valid. Must be between 0 and 100.")
    end
  end

end
