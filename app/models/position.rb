class Position < ActiveRecord::Base
  set_primary_key 'id'
  has_and_belongs_to_many :groups
  belongs_to :group

  lang_attr :title, :description

  def group
    self.groups.first
  end

  def self.find_all_active_positions
    positions = Position.find_all_by_admission_id(5)
    #positions.sort_by {|x| [(x.group.section == nil ? "" :  x.group.section.name_no), x.group.name_no] }
    positions
  end

  def self.find_all_active_positions_alfa #sorterer alfabetisk
    positions = Position.where(:admission_id => 5).order("title_no ASC").all
  end

  def self.published
    Position.where("publish_from < '#{(Time.now + (Time.now + 1.day.ago)).strftime("%Y-%m-%d %H:%M") }' AND publish_to > '#{Time.now.strftime("%Y-%m-%d %H:%M")}'")
  end
end
