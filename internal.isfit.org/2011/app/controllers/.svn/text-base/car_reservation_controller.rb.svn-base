class CarReservationController<ApplicationController

	
	def show
		#Initalize the days the booking will count for
		@startdate = Time.parse("02/19-2009, 16:00")
		@endate = Time.parse("03/02-2009, 16:00")
		@number_of_days = (@endate - @startdate)/(60*60*24) 
		
		#Generates a tabel for all the days
		@daysforres = []
		0.upto(@number_of_days) do |i|
			@daysforres.push(@startdate + i*60*60*24)
		end
		#--End initializing days--
		
		#Find reservations for current day
		if params[:day]
			@time = Time.parse("#{params[:month]}/#{params[:day]}-#{params[:year]}, 00:00")
			@datetime = Time.parse("#{params[:month]}/#{params[:day]}-#{params[:year]}, 00:00").strftime("%Y-%m-%d %H:%M:%S")
		
		else
			@time = @startdate
			@datetime = @startdate.strftime("%Y-%m-%d %H:%M:%S")
		end
		#--END--
		@time_endofweek = @time + (24 - @time.strftime("%H").to_i)*60*60
		@datetime_endofweek = (@time +(24 - @time.strftime("%H").to_i)*60*60).strftime("%Y-%m-%d %H:%M:%S")
		@transportmember = can_access?("car", "edit")
		#Find the current cars and reservations available (transportmember or not)
		if @transportmember
			@cars = Car.find(:all, :conditions =>"deleted = 0", :order=>'name')
			@reservations = CarReservation.find(:all, :conditions =>"time_from >= '#{@datetime}' AND time_from < '#{@datetime_endofweek}' AND deleted = 0")

		else
			@cars = Car.find(:all, :conditions =>"deleted = 0 AND transport_only = 0", :order=>'name')
			@reservations = CarReservation.find_booked_outside_transport(@datetime, @datetime_endofweek)
		end
		#--END--
		@reservation_matrix = []
		24.times do |time|
			@reservation_matrix[time] = []
		end
		#Make a matrix for all the car reservations
		@reservations.each do |res|
			from = res.time_from.strftime("%H").to_i
			to = res.time_to.strftime("%H").to_i - 1
			if to == -1
				to= 23
			end
			if to>=from
				(from).upto(to) do |time|
					@reservation_matrix[time][res.car_id] = res
				end
			end
		end
		
	end
	
	def add
		@today = Time.now
		@time = Time.parse("#{params[:month]}/#{params[:day]}-2009, #{params[:hour]}:00")
		@diff = @time - @today
		@availableforall = true
		@transportmember = can_access?("car", "edit")
		if @diff < 86400
			@availableforall = false
		end
		@currentcar = Car.find(params[:car_id])
		datetime = @time.strftime("%Y-%m-%d %H:%M:%S")
		#Units for transport to choose
      		@user_units = LdapUnit.get_by_dn("ou=isfit09,ou=units,dc=isfit,dc=org").units      
		@units = []
		@units.push(["Everyone","ou=isfit09,ou=units,dc=isfit,dc=org"])
		@user_units.each do |unit|
		    	@units.push([unit.description, unit.dn])
		    	unit.units.each do |subunit|
		    		@units.push([" -> #{subunit.description}", subunit.dn])
			end
		end
		#END
		
		
		current_time = Time.parse("#{params[:month]}/#{params[:day]}-2009, #{params[:hour]}:00").strftime("%Y-%m-%d %H:%M:%S")	
		next_day = (Time.parse("#{params[:month]}/#{params[:day]}-2009, 00:00") + 60*60*24).strftime("%Y-%m-%d %H:%M:%S")
		@carsavail = true
		if params[:car] !=""
			@available_houres = CarReservation.find(:first, :conditions => "car_id = #{params[:car_id]} AND time_from >= '#{current_time}' AND time_to <='#{next_day}' AND deleted = 0", :order => 'time_from')
			if @available_houres !=nil
				@houre_last = @available_houres.time_from.strftime("%H").to_i
				@houres_left = @houre_last - params[:hour].to_i
			else
				@houres_left = 24 - params[:hour].to_i
			end
			if @houres_left > 4
				@houres_left = 4
			end
			@houres_for_res = []
			1.upto(@houres_left) do |i|
				@houres_for_res.push(i)
			end
		else
			@carsavail = false
		end

	end
	
	def update
		
		@transportmember = can_access?("car", "edit")
		if params[:res_id]
			current = CarReservation.find(params[:res_id])
			current.route =  params[:currentreservation][:route]
			current.comment = params[:currentreservation][:comment]
			if current.valid?
				current.save
				if params[:currentreservation][:car_id]
					redirect_to :action=>"resdetails", :car_id=>params[:currentreservation][:car_id], :month=>params[:currentreservation][:month], :day=>params[:currentreservation][:day], :hour=>params[:currentreservation][:hour]
				else
					redirect_to :action=>"manage"
				end
			else
				flash[:warnings] = current.errors
				redirect_to :action=>"edit", :res_id => params[:res_id]
			end
		
		else
			CarReservation.transaction do
				time_from = Time.parse(params[:car_reservation][:time_from]).strftime("%Y-%m-%d %H:%M:%S")
				time_to = (Time.parse(params[:car_reservation][:time_from]) + 60*60*params[:time_to].to_i).strftime("%Y-%m-%d %H:%M:%S")
				@reservations_in_intervall = CarReservation.find(:first, :conditions => "car_id = #{params[:car_reservation][:car_id]} AND time_from <= '#{time_from}' AND time_to >= '#{time_to}' AND deleted=0")
				if @reservations_in_intervall == nil
					@reservation = CarReservation.new(params[:car_reservation])
					@reservation.user_id = current_user.id
					@reservation.deleted = 0
					if @transportmember
							@reservation.group_dn = params[:car_reservations][:unit]
					else
							@reservation.group_dn = current_user.unit.dn
					end
					@reservation.time_to = time_to
					if @reservation.valid?
						@reservation.save
						redirect_to :action=>"show", :day=>Time.parse(params[:car_reservation][:time_from]).strftime("%d"), :month=>Time.parse(params[:car_reservation][:time_from]).strftime("%m"), :year =>Time.parse(params[:car_reservation][:time_from]).strftime("%Y")
					else
						flash[:warnings] = @reservation.errors
						redirect_to :action=>"add", :day=>Time.parse(params[:car_reservation][:time_from]).strftime("%d"), :month=>Time.parse(params[:car_reservation][:time_from]).strftime("%m"), :hour =>Time.parse(params[:car_reservation][:time_from]).strftime("%H"), :car_id =>params[:car_reservation][:car_id]
					end
				end
			end
		end
	end
	
	def details
		@day = Time.parse("#{params[:month]}/#{params[:day]}-2009")
		datetime_startofday = Time.parse("#{params[:month]}/#{params[:day]}-2009").strftime("%Y-%m-%d %H:%M:%S")
		datetime_endofday = Time.parse("#{params[:month]}/#{params[:day].to_i+1}-2009").strftime("%Y-%m-%d %H:%M:%S")
		if params[:car]
			@reservation = CarReservation.find(:all, :conditions => "time_from >= '#{datetime_startofday}' AND time_from < '#{datetime_endofday}' AND car_id = #{params[:car]} AND deleted = 0", :order =>'time_from')
		else
			@reservation = CarReservation.find(:all, :conditions => "time_from >= '#{datetime_startofday}' AND time_from < '#{datetime_endofday}' AND deleted = 0", :order=>'time_from')
		end
		@cars = Car.find(:all, :conditions=>"deleted = 0", :order=>'name')
		@showcars = true
	end
	
	def details_print
		@day = Time.parse("#{params[:month]}/#{params[:day]}-2009")
		datetime_startofday = Time.parse("#{params[:month]}/#{params[:day]}-2009").strftime("%Y-%m-%d %H:%M:%S")
		datetime_endofday = Time.parse("#{params[:month]}/#{params[:day].to_i+1}-2009").strftime("%Y-%m-%d %H:%M:%S")
		if params[:car]
			@reservation = CarReservation.find(:all, :conditions => "time_from >= '#{datetime_startofday}' AND time_from < '#{datetime_endofday}' AND car_id = #{params[:car]} AND deleted = 0 ", :order => 'time_from')
		else
			@reservation = CarReservation.find(:all, :conditions => "time_from >= '#{datetime_startofday}' AND time_from < '#{datetime_endofday}' AND deleted = 0", :order => 'time_from')
		end
		@cars = Car.find(:all, :conditions=>"deleted = 0", :order=>'name')
		
		render(:template => 'car_reservation/details_print', :layout => 'print')
		@showcars = false
	end
	
	def resdetails
		@user = current_user.id
		datetime = Time.parse("#{params[:month]}/#{params[:day]}-2009, #{params[:hour]}:00").strftime("%Y-%m-%d %H:%M:%S")
		@reservation = CarReservation.find(:first, :conditions => "time_from <= '#{datetime}' AND time_to > '#{datetime}' AND car_id = #{params[:car_id]} AND deleted  = 0")
		@time_from = @reservation.time_from.strftime("%A %e. %b from %H:%M to")
		@time_to = @reservation.time_to.strftime("%H:%M")
		@transportmember = can_access?("car", "edit")
	end
	
	def delete
		reservation = CarReservation.find(params[:res_id])
		reservation.attributes = {:deleted =>1}
		reservation.save
		redirect_to :action=>	"manage"
	end
	def manage
		@timenow = Time.now
		@transportmember = can_access?("car", "edit")
		@yourres = CarReservation.find(:all, :conditions => "group_dn = '#{current_user.unit.dn}' AND deleted = 0", :order=> 'time_from')
		       
	end
	
	def edit
		@currentreservation = CarReservation.find(params[:res_id])
		car_id = @currentreservation.car_id
		@currentcar = Car.find(car_id)
	end
end
