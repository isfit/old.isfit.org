class DialogueController < ApplicationController

	helper :sort
	include SortHelper
	

	def index
	end
	
	def print
		@showparticipants = true
		if params[:id] == "1"
			@participants = Dialogue_participant.find(:all, :conditions => "country_id = '184' or country_id = '47' or nationality LIKE 'Cypriot%' ")
		
		elsif params[:id] == "2"
		
			@participants = Dialogue_participant.find(:all, :conditions => "country_id = '65' or nationality LIKE 'Abkhaz%' or nationality = 'Georgian' or id = '368' or id ='57'")
		
		elsif params[:id] == "3"
			@participants = Dialogue_participant.find(:all, :conditions => "country_id = '84' or country_id = '135'")
		
		else
			@showparticipants = false
		end

		render(:template => 'dialogue/print', :layout => 'print')	
	
	end

	def update
		@countries = Country.find(:all, :order=>"name")
		@dialogue_participant = DialogueParticipant.find(params[:id])

		if request.post?
			@dialogue_participant.attributes = params[:dialogue_participant]

			if @dialogue_participant.save
				redirect_to :action => :browse
			else
				flash[:warnings] = @dialogue_participant.errors
			end
		end
	end

	def browse
		sort_init 'dialogue_participants.id'
		sort_update
#		@dialogue_participants = Dialogue_participant.find(:all)
		@dialogue_participants = DialogueParticipant.paginate(:page => params[:page], 
			:order => sort_clause, :include => [:country],
			:conditions => "#{@search_cond}")
	end

	def groups
		@g = Country.find_by_sql("select c.id, c.name, count(q.id) as count from
			countries c inner join dialogue_participants p on p.country_id = c.id 
			left outer join questions q on (
				q.participant_id = p.id and q.answer_datetime is null and
				q.recipient = 'dialogue'
			)
			where p.invited = 1 group by c.id order by c.name")
	end

	def country_group
		if request.post? and params[:question]

			# Create new question
			if params[:rid] == -1.to_s
				@question = Question.new(params[:question])
				@question.participant_id = params[:pid]
				@question.functionary_id = current_user.id
				@question.participant_type = "dialogue"
				@question.recipient = "dialogue"
				@question.question_datetime = DateTime.now
				if @question.answer.chomp != ""
					@question.answer_datetime = DateTime.now
				else
					@question.answer = nil
				end

			# Reply to question
			else
				@question = Question.find(params[:rid])
				@question.attributes = params[:question]
				if @question.answer.strip != ""
					@question.answer_datetime = DateTime.now
				else
					@question.answer_datetime = nil
					@question.answer = nil
				end
			end

			@question.save
			redirect_to :id => params[:id], :pid => params[:pid]
		end

		@c = Country.find(params[:id])
		@p = Participant.find_by_sql("select p.id, p.first_name, p.middle_name,
			p.last_name, count(q.id) as count, 'workshop' as kind from 
			dialogue_participants p left outer join questions q on q.participant_id = p.id and
			q.answer_datetime is null and q.recipient = 'dialogue'
			where p.country_id = #{params[:id]} and p.invited = 1 group by p.id
			order by last_name")
	 	if params[:pid]
				@cp = DialogueParticipant.find(params[:pid])
				@q = Question.find(:all, :conditions => {:participant_id => 
				params[:pid], :recipient =>
				"dialogue"}, :order => "answer_datetime is null desc, question_datetime DESC")
		else
			@q = Question.find_by_sql("(select q.* from questions q inner join
				dialogue_participants p on q.participant_id = p.id where p.country_id =
				#{params[:id]} and p.invited = 1 and q.recipient = 
				'dialogue') order by answer_datetime is null desc, question_datetime DESC")
		end
		if params[:rid] == -1.to_s
			@question = Question.new
		elsif params[:rid]
			@question = Question.find(params[:rid])
				@cp = DialogueParticipant.find(@question.participant_id)
		end
	end

	def delete_question
		Question.delete(params[:id])
		redirect_to(:action => :country_group, :id => params[:cid], :pid => params[:pid])
	end

	def send_to_participant
		q = Question.find(params[:id])
		q.recipient = "participant"
		q.save!
		redirect_to(:action => :country_group, :id => params[:cid], :pid => params[:pid])
	end

end
