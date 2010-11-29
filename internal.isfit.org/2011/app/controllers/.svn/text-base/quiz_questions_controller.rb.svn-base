class QuizQuestionsController < ApplicationController
  # GET /quiz_questions
  # GET /quiz_questions.xml
  def index
    @quiz_questions = QuizQuestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quiz_questions }
    end
  end

  # GET /quiz_questions/1
  # GET /quiz_questions/1.xml
  def show
    @quiz_question = QuizQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz_question }
    end
  end

  # GET /quiz_questions/new
  # GET /quiz_questions/new.xml
  def new
    @quiz_question = QuizQuestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz_question }
    end
  end

  # GET /quiz_questions/1/edit
  def edit
    @quiz_question = QuizQuestion.find(params[:id])
    @quiz = @quiz_question.quiz
    @quiz_choice = QuizChoice.new
  end

  # POST /quiz_questions
  # POST /quiz_questions.xml
  def create
    @quiz_question = QuizQuestion.new
    @quiz_question.quiz = Quiz.find(Integer(params[:quiz_question][:quiz]))
    @quiz_question.body = params[:quiz_question][:body]

    respond_to do |format|
      if @quiz_question.user_can_add(current_user.id) and @quiz_question.save
        choice_nr = 0
        while true
          @quiz_choice = QuizChoice.new
          if (params[:quiz_choice]["desc" + choice_nr.to_s] != nil)
            @quiz_choice.quiz_question = @quiz_question
            @quiz_choice.description = params[:quiz_choice]["desc" + choice_nr.to_s]
            if (params[:quiz_choice]["points" + choice_nr.to_s] != nil)
              @quiz_choice.points = params[:quiz_choice]["points" + choice_nr.to_s]
            else
              @quiz_choice.points = '0'
            end
            
            if (@quiz_choice.description != "")
              @quiz_choice.save
            end
          else
            break
          end
          choice_nr += 1
        end
        format.html { redirect_to(:back) }
        format.xml  { render :xml => @quiz_question, :status => :created, :location => @quiz_question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quiz_questions/1
  # PUT /quiz_questions/1.xml
  def update
    @quiz_question = QuizQuestion.find(params[:id])

    respond_to do |format|
      if @quiz_question.user_can_edit(current_user.id) and @quiz_question.update_attribute(:body, params[:quiz_question][:body])
        flash[:notice] = 'Spørsmålet ble oppdatert.'
        format.html { redirect_to(:back) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_questions/1
  # DELETE /quiz_questions/1.xml
  def destroy
    @quiz_question = QuizQuestion.find(params[:id])
    if @quiz_question.user_can_remove(current_user.id) then
      @quiz_question.destroy
    end

    respond_to do |format|
      flash[:notice] = 'Spørsmålet ble fjernet.'
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
