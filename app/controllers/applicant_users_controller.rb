class ApplicantUsersController < ApplicationController

  before_filter :require_signin!, except: [:new, :create]

	def new
		if current_user
			redirect_to apply_positions_path
		end

		@applicant_user = ApplicantUser.new
	end

	def create
		@applicant_user = ApplicantUser.new(params[:applicant_user])
		@password = @applicant_user.set_password

		if @applicant_user.save
			flash[:notice] = "Epost godkjent"
			Postoffice.new_applicant_user(@applicant_user.mail, @password).deliver
			session[:user_id] = @applicant_user.id
			redirect_to apply_positions_path
		else
			check_creation_errors
			render :new
		end
	end

	def show
		@applicant_user = ApplicantUser.find(current_user)
		@applicant      = @applicant_user.applicant
	end

	private
	def check_creation_errors
		errors = @applicant_user.errors
		if errors.added? :mail, :taken
			@taken = true
		elsif errors.added? :mail, :invalid
			@wrong_format = true
		elsif errors.added? :mail, :blank
			@blank = true
		end
	end
end