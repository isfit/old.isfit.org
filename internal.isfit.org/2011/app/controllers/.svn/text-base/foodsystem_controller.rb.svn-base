class FoodsystemController <ApplicationController
	def index
    
	end

	def get_user_group(current_user)
		if current_user.title =~ /Workshopcontact/
			if current_user.title =~ /Workshopcontact ws(\d+)/
				LdapUnit.get_by_dn(
					"ou=ws#{$~[1]},ou=theme,ou=isfit09,ou=units,dc=isfit,dc=org")
			else
				LdapUnit.get_by_dn(
					"ou=dialogue,ou=project,ou=isfit09,ou=units,dc=isfit,dc=org")
			end
		else
			current_user.unit
		end
	end
	
	def food_order
		
		#En tabell som inneholder nummer og navn på måltidene
		t = Time.now
		startdate = Time.parse("02/18-2009, 20:00")
		current_time = startdate + params[:id].to_i*24*60*60
		@access = true
		if t > current_time
			@access = false
		end
		@meals = [[0,"Lunch"],[1,"Dinner"], [3,"Supper"]]


		@current_group = get_user_group(current_user)
		current_day = params[:id]
		if params[:id] == "-1"
			@current_orders = Food_order.find(:all, :conditions =>"group_id = '#{@current_group.dn}' and will_eat = 1")
			if @current_orders != nil
				@meals_ordered = []
				1.upto(10) do |day|
					@meals_ordered[day] = {}
				end
			end
			@current_orders.each do |person|
				@meals_ordered[person.day][person.user_id] = [0,0,0,0]
			end

			@current_orders.each do |order|
				@meals_ordered[order.day][order.user_id][order.meal_id] = 1
			end
		else
			@persons = @current_group.functionaries
			@current_orders = Food_order.find(:all, :conditions =>"group_id = '#{@current_group.dn}' and day = #{current_day} and will_eat = 1")
			#Lager en tabell som brukes til å vise hvilke personer som skal ha hvilke måltider på aktuell dag
			@meals_ordered = {}
			@persons.each do |person|
				@meals_ordered[person.id] = [0,0,0,0]
			end
			#Fyller tidligere tabell med 1 hvis aktuell person skal ha mat på bestemt måltid		
			@current_orders.each do |order|
				@meals_ordered[order.user_id][order.meal_id] = 1
			end		
		end
	
	end
	
	
	def food_order_outside
		@edit = false
		@db_id = -1
		current_day = params[:id]
		@meals = ["Lunch","Dinner","Dinner - vegetarian","Supper"]
		@current_orders = Food_order.find(:all, :conditions=>"day = #{current_day} and will_eat > 0 and user_id = -1")
		if params[:edit]
			@edit = true
			@db_id = params[:db_id]
			@edit_order = Food_order.find(params[:db_id])
		end
	end
	
	def update_outside

		@meals = ["Lunch","Dinner","Dinner - vegetarian","Supper"]
		food_information = params[:food]
		
		current_day = params[:id]
		current_meal = params[:meal].to_s
		current_number = params[:food][:number]
		current_group = params[:food][:group]
		
		
		test = 0
		meal_counter = 0
		@meals.each do |meal|
			if current_meal == meal
				current_meal = meal_counter
				break
			end
			meal_counter += 1
		end
		
		if params[:edit]
			order = Food_order.find(params[:db_id])
			order.attributes = { :meal_id => current_meal, :user_id => -1, :group_id => current_group, :day => current_day, :will_eat => current_number }
			if order.valid?
				order.save
				redirect_to :action=> "food_order_outside", :id=>params[:id]
			else
				flash[:warnings] = order.errors
				redirect_to :action=> "food_order_outside", :id=>params[:id], :edit=>params[:edit]
			end
		else
			food = Food_order.new(:meal_id => current_meal, :user_id => -1, :group_id => current_group, :day => current_day, :will_eat => current_number)
			if food.valid?
				food.save
				redirect_to :action=> "food_order_outside", :id=>params[:id]
			else
				flash[:warnings] = food.errors
				redirect_to :action=> "food_order_outside", :id=>params[:id]
			end
		end
		
		
		
		
		
	end
	
	def remove_outside
			if Food_order.exists?(:meal_id => params[:meal_id], :user_id => -1, :group_id => params[:group_id], :will_eat => params[:will_eat], :day => params[:id])
				order = Food_order.find(:first, :conditions=>"meal_id = #{params[:meal_id]} and user_id = -1 and group_id = '#{params[:group_id]}' and will_eat = #{params[:will_eat]} and day = #{params[:id]}")
				order.attributes = {:will_eat => 0}
				order.save
			end
		redirect_to :action=>	"food_order_outside", :id=>params[:id]
		
	
	end

	def update
		#Antall måltider, må endres til noe % dager på meal_id
		@meals = [[0,"Lunch"],[1,"Dinner"], [3,"Supper"]]

		@current_group = get_user_group(current_user)
		@persons = @current_group.functionaries

		current_day = params[:id]
		@current_orders = Food_order.find(:all, :conditions =>"group_id = '#{@current_group.dn}' and day = #{current_day} and will_eat = 1 ")
		
		#Lager en tabell som brukes til å vise hvilke personer som skal ha hvilke måltider på aktuell dag
		@meals_ordered = {}
		@persons.each do |person|
			@meals_ordered[person.id] = [0,0,0,0]
		end
		
		#Fyller tidligere tabell med 1 hvis aktuell person skal ha mat på bestemt måltid		
		@current_orders.each do |order|
			@meals_ordered[order.user_id][order.meal_id] = 1
		end
		
		
		@food_ordered = params[:food]
		
		
		#Oppdaterer databasen med endringer gjort i bestillingen.
		@food_ordered.each do |order|
			current_order = order[0].split(/_/)
			current_person = current_order[0].to_i
			current_meal = current_order[1].to_i
			if @meals_ordered[current_person][current_meal] != order[1].to_i
				current_group = @current_group.dn
				if Food_order.exists?(:meal_id => current_meal, :user_id => current_person, :group_id => current_group, :day => current_day)
					@food = Food_order.find(:first, :conditions=>"meal_id = #{current_meal} and user_id = #{current_person} and group_id = '#{current_group}' and day = #{current_day}")
					@food.attributes = {:meal_id => current_meal, :user_id => current_person, :group_id => current_group, :day => current_day, :will_eat => order[1]}
					@food.save
				else
					@food = Food_order.new(:meal_id => current_meal, :user_id => current_person, :group_id => current_group, :day => current_day, :will_eat => order[1])
					@food.save
				end
			end
		end
		redirect_to :action=>	"food_order", :id=>"#{current_day}"
	end
	
	def food_overview
	
		#Aktuell dag blir sendt som :id
		@day = params[:id]
		
		
		#Finner alle som skal spise til de forskjellige måltidene på aktuell dag
		@lunch_eaters = Food_order.find(:all, :conditions=>"day = #{@day} and meal_id= 0 and will_eat >= 1 ", :order=>'group_id LIKE "ou=%" DESC, group_id')
		@dinner_eaters = Food_order.find(:all, :conditions=>"day = #{@day} and meal_id=1 and will_eat >= 1", :order=>'group_id LIKE "ou=%" DESC, group_id')
		@dinnervegetarion_eaters = Food_order.find(:all, :conditions=>"day = #{@day} and meal_id=2 and will_eat >= 1", :order=>'group_id LIKE "ou=%" DESC, group_id')
		@supper_eaters = Food_order.find(:all, :conditions=>"day = #{@day} and meal_id=3 and will_eat >= 1", :order=>'group_id LIKE "ou=%" DESC, group_id')
		
		
		#Inneholder en tabell for hvert måltid, som videre inneholder de gruppene innen isfit som skal spise med antall personer fra hver gruppe.
		@groups_for_lunch = count_eaters(@lunch_eaters)
		@groups_for_dinner = count_eaters(@dinner_eaters)
		@groups_for_dinner_vegetarian = count_eaters(@dinnervegetarion_eaters)
		@groups_for_supper = count_eaters(@supper_eaters)
		
		
		#Inneholder en tabell for hvert måltid, som videre inneholder de personene innen isfit som skal spise med deres allergier.
		@allergies_for_lunch = find_allergies(@lunch_eaters)
		@allergies_for_dinner = find_allergies(@dinner_eaters)
		@allergies_for_dinner_vegetarian = find_allergies(@dinnervegetarion_eaters)
		@allergies_for_supper = find_allergies(@supper_eaters)

		
		#En tabell som inneholder all informasjon om måltidene på den aktuelle dagen
		@current_meals_information = [["Lunch", @groups_for_lunch, @allergies_for_lunch],["Dinner", @groups_for_dinner, @allergies_for_dinner], ["Vegetarian dinner", @groups_for_dinner_vegetarian, @allergies_for_dinner_vegetarian], ["Supper", @groups_for_supper, @allergies_for_supper]]	
		
		
		
		
	end
	
	def food_detail
		#Gjør som food_overview, men bare til ett måltid. 
		@meals = ["Lunch","Dinner","Vegetarian dinner","Supper"]
		@current_eaters = Food_order.find(:all, :conditions=>"day = #{params[:day]} and meal_id = #{params[:id]} and will_eat >= 1 ", :order=>'group_id LIKE "ou=%" DESC, group_id')
		@sorted = []
		@current_eaters.each do |e|
			if e.user_id != -1
				@sorted.push([e, LdapUnit.get_by_dn(e.group_id).description])
			else
				@sorted.push([e, e.group_id])
			end
		end
		@sorted = @sorted.sort do |a,b|
			a[1] <=> b[1]
		end
		@current_eaters = @sorted.collect do |e|
			e[0]
		end
		@current_allergies = find_allergies(@current_eaters)
		
		render(:template => 'foodsystem/food_detail', :layout => 'print')
	end
	
	
	#Returnerer en tabell bestående av grupper i isfit, og antall personer fra denne gruppen som ble hentet i det aktuelle databasesøket
	def count_eaters(current_meal)
		groups_for_meal = {}
		current_meal.each do |eater|
			if eater.user_id == -1
				if groups_for_meal[eater.group_id] != nil
					groups_for_meal[eater.group_id] += eater.will_eat
				else
					groups_for_meal[eater.group_id] = eater.will_eat
				end
					
			else
				if groups_for_meal[LdapUser.get_by_id(eater.user_id).unit.description] != nil
					groups_for_meal[LdapUser.get_by_id(eater.user_id).unit.description] += 1
				else 
					groups_for_meal[LdapUser.get_by_id(eater.user_id).unit.description] = 1
				end
			end
		end
		
		return groups_for_meal
	
	end
	
	#Returnerer en tabell bestående av bruker-id, som igjen inneholder allergier til denne brukeren
	def find_allergies(eaters)
		allergies_for_meal = {}
		eaters.each do |eater|
			if eater.user_id != -1
				if Functionary.exists?(eater.user_id)
					current_eater = Functionary.find(eater.user_id)
					if current_eater.no_allergies == 0
						allergies_for_meal[eater.user_id] = []
						if current_eater.vegetarian == 1
							allergies_for_meal[eater.user_id].push("Vegetarian")
						end
						if current_eater.lactose == 1
							allergies_for_meal[eater.user_id].push("Lactose")
						end
						if current_eater.gluten == 1
							allergies_for_meal[eater.user_id].push("Gluten")
						end
						if current_eater.nut_allergy == 1
							allergies_for_meal[eater.user_id].push("Nut Allergy")
						end
						if current_eater.fruit == 1
							allergies_for_meal[eater.user_id].push("Fruit")
						end
						if current_eater.other != ""
							allergies_for_meal[eater.user_id].push(current_eater.other)
						end
					end
				end
			end
		end
		
		return allergies_for_meal
	
	end
	
	def workshop
	   if request.post?
        temp = params[:workshop].chomp(" ")
        @workshop = Workshop.find(:first, :conditions => "id = '#{temp}'")
	           
	      # creates a list: functionaries of functionaries for the current workshop
        ldap_functionaries = LdapUnit.get_by_dn("ou=ws#{@workshop.id},ou=theme,ou=isfit09,ou=units,dc=isfit,dc=org").functionaries 
        functionaries = []
        
        ldap_functionaries.each do |f| 
          if Functionary.exists?(f.id)
            functionary = Functionary.find(f.id)
            functionaries.push(functionary)
          end
        end
        
        #TODO: Create a table with names of functionaries, participants and belonging allergies
        
        # 1. add functionaries
         
        @results = [[]]
        
        @results[0].push(["Name"],["Vegetarian"],["Lacotes"],["Gluten"],["Other"])
       
        
        @vegetarians = 0
        @lactose = 0
        @gluten = 0
        @other = 0
        
        i = 1
  
        functionaries.each do |f|
          @results[i] = [] if @results[i] == nil
    		  @results[i].push(LdapUser.get_by_id(f.id).firstname + " " + LdapUser.get_by_id(f.id).lastname)
    			if f.vegetarian == 1
    				@results[i].push("X")
    				@vegetarians = @vegetarians + 1
    			else
    				@results[i].push(" ")
    			end
    			if f.lactose == 1
    				@results[i].push("X")
    				@lactose = @lactose + 1
    			else
    				@results[i].push(" ")
    			end
    			if f.gluten == 1
    				@results[i].push("X")
    				@gluten = @gluten + 1
    			else
    				@results[i].push(" ")
    			end
    			if f.other != ""
    				@results[i].push(f.other)
    				@other =  @other + 1
    			else
    				@results[i].push(" ")
    			end
    			i = i + 1
		    end
		    
		    
		    # 2. add participants
		    
		    # finds all the participants attending the current workshop
		    
		    
	      participant = Participant.find(:all, :conditions => "final_workshop = #{@workshop.id} and invited = 1 and checked_in is not null")
        
        # creates a list: answer of participants with allergies
        answer = []
        participant.each do |f|
          temp = Answer.find(:first, :conditions => "id = #{f.id}" )
          unless temp.nil?
              answer.push(temp)
          end
        end
        
      
        answer.each do |f|
          
          @results[i] = [] if @results[i] == nil
          part = Participant.find(:first, :conditions => "id = '#{f.id}'")
          @results[i].push(part.first_name + " " + part.last_name)
       
    			if f.vegetarian == 1
    				@results[i].push("X")
    				@vegetarians = @vegetarians + 1
    			else
    				@results[i].push(" ")
    			end
    			if f.lactose == 1
    				@results[i].push("X")
    				@lactose = @lactose + 1
    			else
    				@results[i].push(" ")
    			end
    			if f.gluten == 1
    				@results[i].push("X")
    				@gluten = @gluten + 1
    			else
    				@results[i].push(" ")
    			end
    			if f.other == 1
    				@results[i].push(f.food_description)
    				@other =  @other + 1
    			else
    				@results[i].push(" ")
    			end
    			i = i + 1
		    end

        @results[i] = []
        @results[i].push(["Sum"],[@vegetarians],[@lactose],[@gluten],[@other])
        
    else 
      # this section lists all the workshops if none is selected
      
      @names = Workshop.find(:all)
	  end
  end
end
