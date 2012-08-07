class Position < ActiveRecord::Base
  set_primary_key 'id'
  has_and_belongs_to_many :groups
  belongs_to :group

  lang_attr :title, :description

  def group
    self.groups.first
  end

  scope :published, lambda { where("publish_from < ? AND publish_to > ?", Time.zone.now, Time.zone.now) }

  def select_name
    "#{self.groups.first.name_no} - #{self.title_no}"
  end
end
