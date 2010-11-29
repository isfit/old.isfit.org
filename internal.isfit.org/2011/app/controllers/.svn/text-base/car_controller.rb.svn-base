class CarController<ApplicationController

	def show
		#Viser hvilke biler som eksisterer
		@allcars = Car.find(:all,:order => "name")
		@access = can_access?("car", "edit")
		@cars = []
		if can_access?("car", "edit")
			@cars = @allcars
		else
			@allcars.each do |car|
				if car.transport_only == 0
					@cars.push(car)
				end
			end
		end
		#Collects information about a specific car
		if params[:id]
			car = Car.find(:all, :conditions => "id = #{params[:id]}")
			car.each do |entry|
				@name = entry.name
				@description = entry.description
				@max = entry.max_passengers
				@short_description = entry.short_description
			end
		end
	end
	
	def add
	end
	
	def update		
		car = Car.new(params[:car])
		name = car.name
		reservations = params[:car]
		
		Car.transaction do
			if params[:id]==nil					
					add_to_db = Car.new(params[:car])
					if Car.exists?(:name => name)
						existing_cars = Car.find(:all, :conditions => "name LIKE '#{name}%'")
						add_to_db.name += " (" + (existing_cars.size+1).to_s + ")"
					end
					add_to_db.deleted = 0
						
				
					unless params[:image] == ""
						path = "#{RAILS_ROOT}/public/images/car_images/" +
						"#{name}.jpg"
						@picture = Picture.new(path, params[:image],400)
						@picture.save
					end
					if add_to_db.valid?
						add_to_db.save	
						redirect_to :action=>"show"
					else
						flash[:warnings] = add_to_db.errors
						redirect_to :action=>"add"
					end
			else
				if Car.exists?(
					:name => name
					)
				
				end
				@message = "We don't know what went wrong..?!"
				car = Car.find(:first, :conditions => "id = #{params[:id]}" )
				car.attributes = params[:car]
						
			
				unless params[:image] == ""
					path = "#{RAILS_ROOT}/public/images/car_images/" +
					"#{name}.jpg"
					@picture = Picture.new(path, params[:image],400)
					@picture.save
				end
				
				if car.valid?
					car.save
					redirect_to :action=>"show"
				else
					flash[:warnings] = car.errors
					redirect_to :action=>"edit", :id=>params[:id]
				end
			end
		end	
	end
		
	def delete
		#Collects information about a specific car
		if params[:id]
			car = Car.find(:all, :conditions => "id = #{params[:id]}")
			car.each do |entry|
				@name = entry.name
				@description = entry.description
				@max = entry.max_passengers
				@short_description = entry.short_description
			end
			@reservation = CarReservation.find(:all, :conditions=>"car_id = #{params[:id]} AND deleted = 0")
		end	
	end
	
	def del
		car = Car.find(:first, :conditions => "id = #{params[:id]}")
		car.attributes = {:deleted => 1}
		car.save
		redirect_to :action=>"show"
		reservations = CarReservation.find(:all, :conditions=>"car_id = #{params[:id]} AND deleted = 0")
		reservations.each do |res|
			res.attributes = {:deleted=>1}
			res.save
		end
	end
	
	def edit
		#Collects information about a specific car
		if params[:id]
			car = Car.find(:all, :conditions => "id = #{params[:id]}")
			car.each do |entry|
				@name = entry.name
				@description = entry.description
				@max = entry.max_passengers
				@short_description = entry.short_description
			end
		end	
	end
end