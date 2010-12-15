module EconomyContactPeopleHelper

end
module ActiveRecord
    class Base  
          def self.to_select_people(economy_contact_unit_id)
            find_all_by_economy_contact_unit_id(economy_contact_unit_id).collect { |x| ["#{x.firstname} #{x.lastname}",x.id] }
          end
    end
end

class Array
    def to_select_people
      self.collect { |x| [x.firstname,x.id] }
    end
end
