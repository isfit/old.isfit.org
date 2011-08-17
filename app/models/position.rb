class Position < ActiveRecord::Base
  has_and_belongs_to_many :groups
  belongs_to :group

  lang_attr :title, :description

  def self.find_all_active_positions
    positions = Position.find_all_by_admission_id(5)
    #positions.sort_by {|x| [(x.group.section == nil ? "" :  x.group.section.name_no), x.group.name_no] }
    positions
  end

  def self.find_all_active_positions_alfa #sorterer alfabetisk
    positions = Position.where(:admission_id => 5).order("title_no ASC").all
  end
end
