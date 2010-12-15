class SweaterController < ApplicationController
  
  # First we need to allow Netaxept to post data to this controller
  protect_from_forgery :only => :purchase
  skip_before_filter :verify_authenticity_token

  # ACTION: index
  # This method render's the items
  def index
	order = SweaterOrder.find(
		:first,
		:conditions => "user_id = #{current_user.id} and abort = 0")
	hide_cheap = false
	unless order.nil?
		hide_cheap = true
	end
	
    @sweaters = []
    sweater = {}
    last_event_id = -1
    Sweater.each do |row|
      event_id = row["event"].to_i
      
		if last_event_id == -1
		  sweater = {}
		  sweater[:title] = row["event_name"]
		  sweater[:event_id] = row["event"]
		  sweater[:prices] = []
		end

      if event_id != last_event_id 
        if last_event_id != -1
		  unless (hide_cheap and sweater[:title] =~ /sponset/i)
          @sweaters.push sweater
		  end 
          sweater = {}
          sweater[:title] = row["event_name"]
		  sweater[:event_id] = row["event"]
          sweater[:prices] = []
        end
        last_event_id = event_id
         
      end
        price = {:id => row["price_group"],:amount => row["price"],
			:size=> row["price_group_name"]}
        sweater[:prices].push price
    end 
	unless (hide_cheap and sweater[:title] =~ /sponset/i)
    	@sweaters.push sweater
	end
  end

  # Action: Verify
  # Method used to make the user verify purchase, and enter samfundet member id
  def verify
    if request.post?  
		purchase = params[:purchase]	
		parameter = purchase[:sweater].split((/_/))
		@price_group = parameter[0]
		@price = parameter[1]
		@size = parameter[2]
		@title = purchase[:title]
		@event_id = purchase[:event_id]
   	end
  end

  # ACTION: Order
  # This method runs the purchase method on sql.samfundet.no and then
  # redirects 
  def order
	if request.post?
		@exception = nil
		purchase = params[:purchase]	
		price_group = purchase[:price_group]
		price = purchase[:price]
		member_id = purchase[:member_id]
		begin
			if(member_id and member_id != "") 
				ret = Sweater.create_single_purchase_member(member_id, price_group, 1)
			else
				ret = Sweater.create_single_purchase("#{current_user.username}@isfit.org", price_group, 1)
			end
		rescue Exception=>e
			@error = true
			@exception = e
		end

		# Check if it is possible to create purchase.
		if !@error and ret[0] != nil
			@error = false
			# Some parameters
			pmd 		= ret[1]
			pmd 		= pmd[1,pmd.size()-2]
			purchase_id = ret[0]

			# Add to sweater_orders as a new order.
			order = SweaterOrder.new(
				:user_id => current_user.id,
				:price_group => price_group,
				:pmd => pmd)
			if member_id and member_id != ""
			order.medlemsnummer = member_id
			end
			order.save
					
			redirect_to (Sweater.payneturl(purchase_id,price,pmd))
		else
			@error = true
		end 
	end
  end

  # ACTION: Purchase
  # paynet calls this action after the user has payed for the item's
  def purchase
    @success = params[:id]=="status=OK"
	@abort = params[:id]=="status=FAIL"

	if @success 
      pmd = params[:PMD]
      payment_method = params[:payment_method]

      # Let us first save the paynet's irrn
      irrn = params[:irrn]
      order = SweaterOrder.find(:first, :conditions => "pmd = #{pmd}")
	  order.irrn = irrn
	  order.payment_method = payment_method
      order.save
      redirect_to :action => :wait, :id => pmd
	elsif @abort
      pmd = params[:PMD]
      order = SweaterOrder.find(:first, :conditions => "pmd = #{pmd}")
	  order.abort = true
      order.save
    end
	
  end

  def wait
    if (params[:id])
      @pmd = params[:id]
      status = Sweater.purchase_status(@pmd)
      @paid = status[0]
      @timeout = status[1]
    end
  end
  
  def show_image
	if (params[:id])
      @id = params[:id]
    end
	render(:template => 'sweater/show_image', :layout => 'print')
  end
end
