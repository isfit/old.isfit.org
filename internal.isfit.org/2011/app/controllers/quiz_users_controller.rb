class QuizUsersController < ApplicationController
  # GET /quiz_users
  # GET /quiz_users.xml
  def index
    @quiz_users = QuizUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quiz_users }
    end
  end

  # GET /quiz_users/1
  # GET /quiz_users/1.xml
  def show
    @quiz_user = QuizUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz_user }
    end
  end

  # GET /quiz_users/new
  # GET /quiz_users/new.xml
  def new
    @quiz_user = QuizUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz_user }
    end
  end

  # GET /quiz_users/1/edit
  def edit
    @quiz_user = QuizUser.find(params[:id])
  end

  # POST /quiz_users
  # POST /quiz_users.xml
  def create
    @quiz_user = QuizUser.new(params[:quiz_user])

    respond_to do |format|
      if @quiz_user.save
        flash[:notice] = 'QuizUser was successfully created.'
        format.html { redirect_to(@quiz_user) }
        format.xml  { render :xml => @quiz_user, :status => :created, :location => @quiz_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quiz_users/1
  # PUT /quiz_users/1.xml
  def update
    @quiz_user = QuizUser.find(params[:id])

    respond_to do |format|
      if @quiz_user.update_attributes(params[:quiz_user])
        flash[:notice] = 'QuizUser was successfully updated.'
        format.html { redirect_to(@quiz_user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_users/1
  # DELETE /quiz_users/1.xml
  def destroy
    @quiz_user = QuizUser.find(params[:id])
    @quiz_user.destroy

    respond_to do |format|
      format.html { redirect_to(quiz_users_url) }
      format.xml  { head :ok }
    end
  end
end
