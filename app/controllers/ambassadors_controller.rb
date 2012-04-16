class AmbassadorsController < ApplicationController
  def index
    # Temporary, until we get buttons
    redirect_to ambassadors_new_path
  end

  def new

    render text: "Registrations for International Ambassadors has closed", layout: true

    @ambassador = Ambassador.new
    @contact_types = { "Person" => 1,
                       "University" => 2,
                       "Embassy" => 3 }
    
  end

  def create
    @ambassador = Ambassador.new(params[:ambassador])
    if @ambassador.save
      redirect_to ambassadors_thank_you_path, :notice => "Your registration was successfull"
    else
      @contact_types = { "Person" => 1,
                       "University" => 2,
                       "Embassy" => 3 }
 
      render :new
    end
  end

  def thank_you
  end
end
