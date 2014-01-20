class SessionsController < ApplicationController
	def new
	end

	def create
    user = ApplicantUser.where(:mail => params[:signin][:mail]).first

    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      flash[:notice] = "Velkommen."

      redirect_to show_applicant_user_path
    else
      @wrong_password = true
      render :new
    end
  end

  def forgotten_password
  end

  def new_password
    email = params[:mail]
    user = ApplicantUser.where(mail: email).first

    password = user.set_password

    if user.save
      Postoffice.new_password(email, password).deliver
      flash[:notice] = "Passord sendt til #{email}"
      redirect_to signin_path
    else
      render :forgotten_password
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Du har blitt logget ut."
  end
end