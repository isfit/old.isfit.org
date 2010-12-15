class PersonalContact < ActiveRecord::Base
  belongs_to :country
  validates_numericality_of :zip_code
  validates_presence_of :address, :firstname, :lastname, :email, :city

  def self.find_country_by_region_id(region_id)
    Country.find_by_sql("SELECT c.id, c.name FROM countries as c, regions as r WHERE c.region_id = r.id AND r.id = #{region_id}")
  end

  def self.count_contacts_by_country_id(country_id)
    Country.count_by_sql("SELECT COUNT(*) FROM personal_contacts AS p, countries AS c WHERE p.country_id = c.id AND c.id = #{country_id} GROUP BY c.id")
  end

  def self.count_contacts_by_country_id_and_type(country_id, type)
    Country.count_by_sql("SELECT COUNT(*) FROM personal_contacts AS p, countries AS c WHERE p.country_id = c.id AND p.infopackage_contact_type_id = #{type}  AND c.id = #{country_id} GROUP BY c.id")
  end
  def self.count_by_type(type)
    PersonalContact.count_by_sql("SELECT COUNT(*) FROM personal_contacts AS p WHERE p.infopackage_contact_type_id = #{type}") 
  end
  def self.count_by_region_id_and_type(region_id,type)
    PersonalContact.count_by_sql("SELECT COUNT(*) FROM personal_contacts AS p, countries AS c, regions AS r WHERE p.country_id = c.id AND c.region_id = r.id AND r.id = #{region_id} AND p.infopackage_contact_type_id = #{type} GROUP BY r.id")
  end
end
