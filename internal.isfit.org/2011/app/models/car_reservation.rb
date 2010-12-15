class CarReservation<ActiveRecord::Base
	belongs_to :car
	validates_presence_of :comment, :message=> "Please enter a comment"
	validates_presence_of :route, :message=> "Please enter a route"
	def self.time_is_booked?(time)
		if self.find_by_time_from(time) != nil
			self.find_by_time_from(time) == Car.find(:all, :conditions=> 'deleted=0').size
		end
	end
	
	def self.find_booked_outside_transport(timefrom, timeto)
		CarReservation.find_by_sql("SELECT * FROM car_reservations WHERE car_id NOT IN (SELECT id FROM cars WHERE transport_only = 1) AND deleted = 0 AND time_from >= '#{timefrom}' AND time_from <= '#{timeto}'")
	end
	
end