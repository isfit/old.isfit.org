class RoombookingController <ApplicationController

	def index
		redirect_to :action => :show
	end 
	
	def show
		#Collects rooms from the DB
		@rooms = Room.find(:all)
		
		#The valid times you can book a room
		@times = [[0,"08.00-09.00",8], [1,"09.00-10.00",9], [2,"10.00-11.00",10], [3,"11.00-12.00",11], [4,"12.00-13.00",12], [5,"13.00-14.00",13], [6,"14.00-15.00",14], [7,"15.00-16.00",15], [8,"16.00-17.00",16], [9,"17.00-18.00",17], [10,"18.00-19.00",18], [11,"19.00-20.00",19], [12,"20.00-21.00",20], [13,"21.00-22.00",21], [14,"22.00-23.00",22], [15,"23.00-24.00",23]]
		#Times printed out in the view
		@print_times = ["08.00", "09.00", "10.00","11.00","12.00","13.00","14.00","15.00","16.00","17.00","18.00","19.00","20.00","21.00","22.00","23.00","24.00"]
		
		#The days in a week
		@days = [[0,"Monday"], [1,"Tuesday"], [2,"Wednesday"], [3,"Thursday"], [4,"Friday"], [5,"Saturday"],[6,"Sunday"]]
    
		#Finds the week and year the booking should apply for. Default is current week.
		t = Time.now
		@current_week = Integer(t.strftime("%W")) 
		@current_year = Integer(t.strftime("%Y"))
		@current_time = t.strftime("%H").to_i
		@current_day  = Integer(t.strftime("%w")) -1
		if params[:id]
			date = params[:id].split(/_/)
			@week = Integer(date[0])
			@year = Integer(date[1])
			if (@week < @current_week and @year == @current_year) or @year < @current_year or @week > @current_week +20 or @year > @current_year + 1
				@week = @current_week
				@year = @current_year
				redirect_to :action=>"show", :id=>"#{@week}_#{@year}"
			elsif @week > 52
				@year += 1 
				redirect_to :action=>"show", :id=>"1_#{@year}"
			
			elsif @week < 1
				@year -= 1
				redirect_to :action=>"show", :id=>"52_#{@year}"
					
			end
		else 
			@week = @current_week
			@year = @current_year
	  	end
	  			
		#Collects roombookings from the DB
		@roombookings = Roombooking.find(:all, :conditions => "week = #{@week} and year = #{@year}")
			
		#Generates a matrix with roomes, dayes and times.
    		@bookings = []
    		@days.each do |day|
    			@bookings[day[0]] = []
        		@times.each do |time|
        			@bookings[day[0]][time[0]] = []
        			@rooms.each do |room|
        	  			@bookings[day[0]][time[0]][room.id] = nil
        			end
      			end
    		end
    		
    		@roombookings.each do |booking|
      			day_int = booking.day_id
      			time_int = booking.time_id
      			room_int = booking.room_id
      			@bookings[day_int][time_int][room_int] = (booking.user_id)
    		end
	end
	
	def update
		
    	#Defines the year
      	t = Time.now
      	@current_year = Integer(t.strftime("%Y"))
      	@year = @current_year
		
		#Finds all info about the booking
		bookings = params[:room].sort()
		@antall_tider_booket = 0
		@day = []
    		@day_id = []
		@time = []
    		@time_id = []
		@week = []
		@room_id = []
		@room_name = []
		@this_year = []
		bookings.each do |booking|
			if booking[1] == "1" then   
				booking_info = booking[0].split(/_/)
				@day_id.push(booking_info[0])
        			@day.push(booking_info[1])
        			@time_id.push(booking_info[2])
				@time.push(booking_info[3])
				@week.push(booking_info[4])
				@room_id.push(booking_info[5])
				@room_name.push(booking_info[6])
				@this_year.push(booking_info[7])
				@antall_tider_booket += 1
			end
		end
		#Updates the DB if it not exists
		Roombooking.transaction do
			@cancel = false
			for i in 0..@day.length-1
				if Roombooking.exists?(
						:day_id => @day_id[i],
						:week => @week[i], 
						:year => @this_year[i],
						:room_id => @room_id[i],
						:time_id => @time_id[i]
						)
					@cancel = true
					break
				end			
			end		
				
			break if @cancel
			
			for i in 0..@day.size-1			
				@add_booking = Roombooking.new(
						:day_id => @day_id[i],
						:week => @week[i], 
						:year => @this_year[i],
						:user_id => current_user.id,
						:room_id => @room_id[i],
						:time_id => @time_id[i]
						)
				@add_booking.save		
			end
		end
	end
	
	#delete current booking
	def remove
		if params[:id]
			removebooking = params[:id].split(/_/)
			Roombooking.delete_all("day_id =#{removebooking[0]} and time_id =#{removebooking[1]} and week=#{removebooking[2]} and room_id=#{removebooking[3]} and user_id=#{current_user.id} and year=#{removebooking[4]}")
		end
		redirect_to :action=>	"show", :id=>"#{removebooking[2]}_#{removebooking[4]}"
	end
	
end
