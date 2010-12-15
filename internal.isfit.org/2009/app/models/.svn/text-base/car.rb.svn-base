class Car<ActiveRecord::Base
	has_many :car_reservations
	
	#Validate General
    validates_presence_of :name, :message => "Name can't be blank"
    validates_presence_of :description, :message => "Description can't be blank"
    validates_presence_of :short_description, :message => "Short description can't be blank"
    validates_presence_of :max_passengers, :message => "Max passengers can't be blank"
	
    validates_uniqueness_of :name, 
		:message => "The name must be unique"
	@existing_cars = Car.find(:all)
	
	def is_booked_in_timeinterval?(timeintv)
		CarReservation.find(:all, :conditions => "car_id = #{self.id} and time_from = #{timeintv}").size > 0
	end
	
	def self.find_unbooked_cars(timeintv)
		Car.find_by_sql("SELECT * FROM cars WHERE id NOT IN (SELECT c.id FROM cars c INNER JOIN car_reservations cr ON car_id = c.id AND cr.time_from <= '#{timeintv}' AND cr.time_to >'#{timeintv}' AND cr.deleted =0) AND deleted=0 ORDER BY name")
	end
	
	def self.find_reserved_car(car_id)
		Car.find(car_id)
	end
end