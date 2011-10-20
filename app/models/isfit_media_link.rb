class IsfitMediaLink < ActiveRecord::Base
  lang_attr :short_desc, :long_desc
  def self.find_five_latest(en = false)
    if en
      IsfitMediaLink.where(:deleted => 0).where("short_desc_en IS NOT NULL").where("short_desc_en <> ''").order("created_at DESC").limit(5)    
    else
      IsfitMediaLink.where(:deleted => 0).where("short_desc_no IS NOT NULL").where("short_desc_no <> ''").order("created_at DESC").limit(5)
    end
  end
end
