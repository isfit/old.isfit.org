class QuizChoicesController < ApplicationController
  # GET /quiz_choices
  # GET /quiz_choices.xml
  def index
    @quiz_choices = QuizChoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quiz_choices }
    end
  end

  # GET /quiz_choices/1
  # GET /quiz_choices/1.xml
  def show
    @quiz_choice = QuizChoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz_choice }
    end
  end

  # GET /quiz_choices/new
  # GET /quiz_choices/new.xml
  def new
    @quiz_choice = QuizChoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz_choice }
    end
  end

  # GET /quiz_choices/1/edit
  def edit
    @quiz_choice = QuizChoice.find(params[:id])
  end

  # POST /quiz_choices
  # POST /quiz_choices.xml
  def create
    @quiz_choice = QuizChoice.new
    @quiz_choice.points = Integer(params[:quiz_choice][:points])
    @quiz_choice.quiz_question = QuizQuestion.find(Integer(params[:quiz_choice][:quiz_question]))
    @quiz_choice.description = params[:quiz_choice][:description]

    respond_to do |format|
      if @quiz_choice.user_can_add(current_user.id) and @quiz_choice.save
        flash[:notice] = 'Spørsmålsalternativet ble lagt til.'
        format.html { redirect_to(:back) }
        format.xml  { render :xml => @quiz_choice, :status => :created, :location => @quiz_choice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz_choice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quiz_choices/1
  # PUT /quiz_choices/1.xml
  def update
    @quiz_choice = QuizChoice.find(params[:id])

    respond_to do |format|
      if @quiz_choice.user_can_edit(current_user.id) and @quiz_choice.update_attributes(params[:quiz_choice])
        flash[:notice] = 'Spørsmålsalternativet ble oppdatert.'
        format.html { redirect_to(:controller => "quiz_questions", :id => @quiz_choice.quiz_question.id, :action => "edit") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz_choice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_choices/1
  # DELETE /quiz_choices/1.xml
  def destroy
    @quiz_choice = QuizChoice.find(params[:id])
    if @quiz_choice.user_can_remove(current_user.id)
      @quiz_choice.destroy
    end

    respond_to do |format|
      flash[:notice] = 'Spørsmålsalternativet ble fjernet.'
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
