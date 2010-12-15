class QuizzesController < ApplicationController

  def highscore
    @quiz = Quiz.find(params[:id])
    #@best_users = QuizUser.find_by_sql("SELECT *, points/guesses AS rating FROM `quiz_users` WHERE quiz_id=" + (@quiz.id).to_s + " ORDER BY rating DESC, points DESC LIMIT 10")
    @best_users = QuizUser.get_best_users(@quiz.id)
    respond_to do |format|
      format.html # highscore.html.erb
      format.xml  { render :xml => @quizzes }
    end
  end

  # GET /quizzes
  # GET /quizzes.xml
  def index
    @quizzes = Quiz.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quizzes }
    end
  end

  def register_answer
    quiz_choice = QuizChoice.find(params[:quiz_choice][:id])
    quiz_question = quiz_choice.quiz_question
    quiz = quiz_question.quiz
    quiz_user = QuizUser.find_by_user_id_and_quiz_id(current_user.id, quiz.id)

    # Register guesses and points and save user
    quiz_user.guesses += 1
    quiz_user.points += quiz_choice.points
    # Set question-ID negative to indicate that user has answered question
    quiz_user.quiz_question_id = -quiz_question.id
    quiz_user.save

    if (quiz_choice.points > 0)
      flash[:notice] = 'Riktig svar!<br /><br />'
    else
      flash[:notice] = 'Feil svar!<br /><br />'
    end

    respond_to do |format|
      format.html { redirect_to(quiz_path(params[:tab], quiz)) }
      format.xml  { head :ok }
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.xml
  def show
    # Sets random number seed (based on time etc.)
    srand
    @quiz = Quiz.find(params[:id])

    @quiz_user = QuizUser.find_by_user_id_and_quiz_id(current_user.id, @quiz.id)
    # If Quiz has no QuizUser corresponding to the current user: Add a QuizUser and retry
    if (@quiz_user == nil) then
      @quiz_user = QuizUser.new
      @quiz_user.quiz_id = @quiz.id
      @quiz_user.user_id = current_user.id
      @quiz_user.points = 0
      @quiz_user.guesses = 0
      @quiz_user.quiz_question_id = 0
      @quiz_user.save
      @quiz_user = QuizUser.find_by_user_id_and_quiz_id(current_user.id, @quiz.id)
    end

    @question = nil
    @choices = nil

    # Find a new question if:
    #  - There are more than 4 questions in the quiz
    #  - User is not locked to a question
    #  - The question is different from the one the user just answered
    @questions_length = @quiz.quiz_questions.length
    if (@questions_length > 4) then
      has_answered = 0
      find_question = true
      if (@quiz_user.quiz_question_id > 0)
        # Lock user to this question
        @question = QuizQuestion.find_by_id(@quiz_user.quiz_question_id)
        find_question = false
      elsif (@quiz_user.quiz_question_id < 0)
        # Do not serve this question to user
        has_answered = -(@quiz_user.quiz_question_id)
      end
      
      while (find_question)
        @question = @quiz.quiz_questions[rand(@questions_length)]
        if (@question.id != has_answered)
          find_question = false
        end
      end
      @quiz_user.quiz_question_id = @question.id
      @quiz_user.save
    end

    if @question != nil and @question.quiz_choices.length > 1 then
      @choices = @question.quiz_choices
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz }
    end
  end

  # GET /quizzes/new
  # GET /quizzes/new.xml
  def new
    @quiz = Quiz.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz }
    end
  end

  # GET /quizzes/1/edit
  def edit
    @quiz = Quiz.find(params[:id])
    @quiz_question = QuizQuestion.new
  end

  # POST /quizzes
  # POST /quizzes.xml
  def create
    @quiz = Quiz.new(params[:quiz])
    @quiz.owner_id = current_user.id

    respond_to do |format|
      if Quiz.user_can_add(current_user.id) and @quiz.save
        flash[:notice] = 'Quiz\'en ble lagt til.'
        format.html { redirect_to(quizzes_url) }
        format.xml  { render :xml => @quiz, :status => :created, :location => @quiz }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quizzes/1
  # PUT /quizzes/1.xml
  def update
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      if @quiz.user_can_edit(current_user.id) and @quiz.update_attributes(params[:quiz])
        flash[:notice] = 'Quiz\'en ble oppdatert.'
        format.html { redirect_to(:back) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.xml
  def destroy
    @quiz = Quiz.find(params[:id])
    if @quiz.user_can_remove(current_user.id) then
      @quiz.destroy
    end

    respond_to do |format|
      format.html { redirect_to(quizzes_url) }
      format.xml  { head :ok }
    end
  end
end
