class Position < ActiveRecord::Base
  self.primary_key = 'id'
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

  def self.all_ordered_by_section_name_position_name
    join_condition = "INNER JOIN sections ON sections.id = groups.section_id"
    order_by = "sections.name_no, case when substring(positions.title_no, 1, 9)" +
      " = 'Nestleder' then 0 else 1 end, case when substring(positions.title_no, 1, 23)"+ 
      " = 'Prosjektansvarlig i IT' then 1 else 0 end" +
      ", positions.title_no"

    self.published
      .joins(:groups)
      .joins(join_condition)
      .order(order_by)
  end
end
