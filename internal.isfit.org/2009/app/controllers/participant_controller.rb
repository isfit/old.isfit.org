require 'digest/sha1'

class ParticipantController < ApplicationController

	helper :sort
	include SortHelper

	def index
	end

	def overdue_requests
		if request.post? and params[:travel_request]
				p = Participant.find(params[:travel_request][:id])				
			if params[:accept]
				p.accept_travel = 1
				p.accept_travel_time = DateTime.now
				p.save
			elsif params[:reject]
				p.accept_travel = 0
				p.save
			end
		end

		@participants = Participant.find(:all, :conditions => 
			'not request_travel is null and blocked = 0', 
			:order => 'accept_travel = 1, request_travel', :include => 'country',
			:joins => 'left outer join answers a on a.id = participants.id')
	end
	
	def host_preferences
	sort_init 'id'
	sort_update
	
	filter = ""
	filter += "smoke = #{params[:smoke].to_i-1} and " if params[:smoke].to_i > 0
	filter += "handicap = #{params[:handicap].to_i-1} and " if params[:handicap].to_i > 0
	
	filter += "(stay_with = 'FEMALE') and " if params[:stay_with].to_i == 1 # != 2 and params[:stay_with].to_i != 0 and params[:stay_with].to_i != 3 and not params[:stay_with].nil?
	filter += "(stay_with = 'MALE') and " if params[:stay_with].to_i == 2 # != 1 and  params[:stay_with].to_i != 0 and params[:stay_with].to_i != 3 and not params[:stay_with].nil?
	filter += "(stay_with = 'NO_MATTER') and" if params[:stay_with].to_i == 3 # != 1 and params[:stay_with].to_i != 2 and params[:stay_with].to_i != 0 and not params[:stay_with].nil?
	
	@count = Participant.count(:conditions =>
		"#{filter} invited = 1 and not arrival_date is null and attend = 1",
		:include => :country, :joins => 'left outer join answers on answers.id = participants.id')
	
	@per_page = params[:per_page] ? params[:per_page].to_i : 20
	    	
		if @per_page != 0
			@participants = Participant.paginate(:page => params[:page], 
				:order => sort_clause,:per_page => @per_page, :conditions =>
				"#{filter} invited = 1 and not arrival_date is null and attend = 1",
				:include => :country, :joins => 'left outer join answers on answers.id =
				participants.id')
		else
			@participants = Participant.find(:all, :order => sort_clause, :conditions =>
				"#{filter} invited = 1 and not arrival_date is null and attend = 1",
				:include => :country, :joins => 'left outer join answers on answers.id = participants.id')
		end
	end

	def attending
  	sort_init 'id'
    	sort_update

		filter = ""
		filter += "final_workshop = #{params[:ws].to_i} and " if params[:ws].to_i > 0
		filter += "(visa = 'NO_NEED_OF_VISA' or visa = 'VISA_BEEN_GRANTED') and " if
			params[:visa].to_i == 1
		filter += "(visa = 'APPLICATION_NOT_PROCESSED' or visa = 'VISA_BEN_REJECTED') and " if
			params[:visa].to_i == 2

    	@count = Participant.count(:conditions =>
			"#{filter} invited = 1 and not arrival_date is null and attend = 1",
			:include => :country, :joins => 'left outer join answers on answers.id = participants.id')

		@per_page = params[:per_page] ? params[:per_page].to_i : 20
    	
		if @per_page != 0
			@participants = Participant.paginate(:page => params[:page], 
				:order => sort_clause,:per_page => @per_page, :conditions =>
				"#{filter} invited = 1 and not arrival_date is null and attend = 1",
				:include => :country, :joins => 'left outer join answers on answers.id = participants.id')
		else
			@participants = Participant.find(:all, :order => sort_clause, :conditions =>
				"#{filter} invited = 1 and not arrival_date is null and attend = 1",
				:include => :country, :joins => 'left outer join answers on answers.id = participants.id')
		end
	end

	def show
		@participant = Participant.find(params[:id])
	end

	def forum
		@username = current_user.username
		@token = "uTue9lee-#{@username}-Wee7equi-#{
			DateTime.now.strftime("%Y-%m-%d-%H:%M")}"
		@token = Digest::SHA1.hexdigest(@token)
	end

	def groups
		@logged_in = Participant.find_by_sql("Select count(*) as count from 
			participants where not last_login is null")
		@answered = Answer.find_by_sql("Select attend, count(*) as count from 
			answers group by attend order by attend desc")

		@g1 = Country.find_by_sql("select c.id, c.name, count(q.id) as count from
			countries c inner join (
				(select id, country_id, 'workshop' as kind from participants p1 
					where invited = 1) union
				(select id, country_id, 'dialogue' as kind from dialogue_participants p2
					where invited = 1)
			)
			p on p.country_id = c.id left outer join questions q on (
				q.participant_id = p.id and q.answer_datetime is null and
				q.recipient = 'participant' and
				(
					(q.participant_type = p.kind) or
					(q.participant_type = p.kind)
				)
			) where c.region_id = 5 group by c.id order by c.name")

		@g2 = Country.find_by_sql("select c.id, c.name, count(q.id) as count from
			countries c inner join (
				(select id, country_id, 'workshop' as kind from participants p1 
					where invited = 1) union
				(select id, country_id, 'dialogue' as kind from dialogue_participants p2
					where invited = 1)
			)
			p on p.country_id = c.id left outer join questions q on (
				q.participant_id = p.id and q.answer_datetime is null and
				q.recipient = 'participant' and
				(
					(q.participant_type = p.kind) or
					(q.participant_type = p.kind)
				)
			) where c.region_id = 1 group by c.id order by c.name")

		@g3 = Country.find_by_sql("select c.id, c.name, count(q.id) as count from
			countries c inner join (
				(select id, country_id, 'workshop' as kind from participants p1 
					where invited = 1) union
				(select id, country_id, 'dialogue' as kind from dialogue_participants p2
					where invited = 1)
			)
			p on p.country_id = c.id left outer join questions q on (
				q.participant_id = p.id and q.answer_datetime is null and
				q.recipient = 'participant' and
				(
					(q.participant_type = p.kind) or
					(q.participant_type = p.kind)
				)
			) where c.region_id = 4 group by c.id order by c.name")

		@g4 = Country.find_by_sql("select c.id, c.name, count(q.id) as count from
			countries c inner join (
				(select id, country_id, 'workshop' as kind from participants p1 
					where invited = 1) union
				(select id, country_id, 'dialogue' as kind from dialogue_participants p2
					where invited = 1)
			)
			p on p.country_id = c.id left outer join questions q on (
				q.participant_id = p.id and q.answer_datetime is null and
				q.recipient = 'participant' and
				(
					(q.participant_type = p.kind) or
					(q.participant_type = p.kind)
				)
			) where c.region_id = 3 group by c.id order by c.name")

		@g5 = Country.find_by_sql("select c.id, c.name, count(q.id) as count from
			countries c inner join (
				(select id, country_id, 'workshop' as kind from participants p1 
					where invited = 1) union
				(select id, country_id, 'dialogue' as kind from dialogue_participants p2
					where invited = 1)
			)
			p on p.country_id = c.id left outer join questions q on (
				q.participant_id = p.id and q.answer_datetime is null and
				q.recipient = 'participant' and
				(
					(q.participant_type = p.kind) or
					(q.participant_type = p.kind)
				)
			) where c.region_id = 2 group by c.id order by c.name")
	end

	def country_group
		if request.post? and params[:question]

			# Create new question
			if params[:rid] == -1.to_s
				@question = Question.new(params[:question])
				@question.participant_id = params[:pid]
				@question.functionary_id = current_user.id
				@question.participant_type = params[:type]
				@question.recipient = "participant"
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
			redirect_to :id => params[:id], :pid => params[:pid],
				:type => params[:type]
		end

		@c = Country.find(params[:id])
		@p = Participant.find_by_sql("(select p.id, p.first_name, p.middle_name,
			p.last_name, count(q.id) as count, 'workshop' as kind from 
			participants p left outer join questions q on q.participant_id = p.id and
			q.answer_datetime is null and q.participant_type = 'workshop'
			where p.country_id = #{params[:id]} and p.invited = 1 group by p.id)" + " union " +
			"(select dp.id, dp.first_name, dp.middle_name, dp.last_name, count(q2.id) as count, 'dialogue' as kind from dialogue_participants dp
			left outer join questions q2 on q2.participant_id = dp.id and
			q2.answer_datetime is null and q2.recipient = 'participant' and
			q2.participant_type = 'dialogue'
			where dp.country_id = #{params[:id]} and dp.invited = 1 group by
			dp.id) order by last_name")
	 	if params[:pid]
			if params[:type] == "dialogue" then
				@cp = DialogueParticipant.find(params[:pid])
				@q = Question.find(:all, :conditions => {:participant_id => 
				params[:pid], :recipient => "participant", :participant_type =>
				"dialogue"}, :order => "answer_datetime is null desc, question_datetime DESC")
			else
				@cp = Participant.find(params[:pid])
				@q = Question.find(:all, :conditions => {:participant_id => 
				params[:pid], :participant_type => "workshop"}, :order => "answer_datetime is null desc, question_datetime DESC")
			end
		else
			@q = Question.find_by_sql("(select q.* from questions q inner join
				participants p on q.participant_id = p.id where p.country_id =
				#{params[:id]} and p.invited = 1 and q.participant_type = 
				'workshop') " + " union " +
				"(select q2.* from questions q2 inner join dialogue_participants dp
				on q2.participant_id = dp.id where dp.country_id = #{params[:id]}
				and dp.invited = 1 and q2.recipient = 'participant' and 
				q2.participant_type = 'dialogue') order by answer_datetime is null desc, question_datetime DESC")
		end
		if params[:rid] == -1.to_s
			@question = Question.new
		elsif params[:rid]
			@question = Question.find(params[:rid])
			if params[:type] == "dialogue" then
				@cp = DialogueParticipant.find(@question.participant_id)
			else
				@cp = Participant.find(@question.participant_id)
			end
		end
	end

	def delete_question
		Question.delete(params[:id])
		redirect_to(:action => :country_group, :id => params[:cid], :pid => params[:pid], :type => params[:type])
	end

	def send_to_dialogue
		q = Question.find(params[:id])
		q.recipient = "dialogue"
		q.save!
		redirect_to(:action => :country_group, :id => params[:cid], :pid => params[:pid], :type => params[:type])
	end

	def print
		start = params[:start] if params[:start]
		stop = params[:stop] if params[:stop]
		order = params[:order] if params[:order]
		ws = params[:ws] if params[:ws]
			
		@participants = Participant.find(:all, :conditions => 
			"participant_grade > 0 AND id >= #{start} AND id <= #{stop} " +
				"AND workshop1 = #{ws}", :order => order ? order : "id")

		render(:template => 'participant/print', :layout => 'print')
	end
	
  def list_participants_for_checkin
    sort_init 'participants.id'
  	sort_update

		@total_count = Participant.count(:conditions => "a.attend = 1",
			:joins => "inner join answers a on a.id = participants.id")
		@matched_count = Participant.count(:conditions => "not host_id is null")
  	
    @participants = Participant.paginate(:page => params[:page], :order => sort_clause,:per_page => 50, 
                                    :include => [:answer, :country], 
                                    :conditions => "participants.id = answers.id AND answers.attend = 1")
  end  
  def list_participants_for_pickup
    if params[:id]
      sort_init 'participants.id'
    	sort_update
  	
      @participants = Participant.paginate(:page => params[:page], :order => sort_clause,:per_page => 50, 
                                      :include => :country,
                                      :conditions => "host_id = #{params[:id]}")  
    end
    
  end
	
	def browse_for_checkin
  	  sort_init 'id'
    	sort_update
    	
    	sc = params[:search_criteria]
    	if sc == ''	   
    	  @participants = Participant.paginate(:page => params[:page], :order => sort_clause,:per_page => 50, 
    	                              :include => [:answer, :country], 
    	                              :conditions => "participants.id = answers.id AND answers.attend = 1")
  	  else
  	    if sc.chomp =~ /^\d+$/
    	    @participants = Participant.paginate(:page => params[:page], :order => sort_clause,:per_page => 50, 
    	                              :include =>  [:answer, :country], 
    	                              :conditions => "participants.id = answers.id AND answers.attend = 1 AND participants.id = #{sc}")
    	  else
    	    query = " participants.first_name LIKE '%#{sc}%' OR participants.last_name LIKE '%#{sc}%' OR countries.name LIKE '%#{sc}%'"
    	    @participants = Participant.paginate(:page => params[:page], :order => sort_clause,:per_page => 50, 
    	                              :include =>  [:answer, :country], 
    	                              :conditions => "participants.id = answers.id AND answers.attend = 1 AND (#{query})")
    	  end
  	  end
  	 	render(:template => 'participant/list_participants_for_checkin')
	end
	def check_in_participant
	  participant = Participant.find_by_id(params[:id])
	  if params[:undo]
	    participant.checked_in = nil
	  else
	    participant.checked_in = Time.now
	  end
    participant.save
    redirect_to :action => "list_participants_for_checkin"
	end	
	
	def pickup_participant
	  participant = Participant.find_by_id(params[:id])
	  if params[:undo]
	    participant.picked_up = nil
	  else
	    participant.picked_up = Time.now
	  end
    participant.save
    redirect_to :action => "list_participants_for_pickup", :id => params[:host_id]
	end
	def letters
		@participants = Participant.find(:all, :conditions => "invited = 1",
			:order => "final_workshop, id")

		render(:template => 'participant/letters', 
			:layout => 'print')
	end

	def posters
		@participants = Participant.find(:all, :conditions => "invited = 1",
			:order => "final_workshop, id")

		render(:template => 'participant/posters', 
			:layout => 'print')
	end

	def grade
		unless Participant.exists?(params[:id])
			redirect_to :action => 'browse', :page => params[:page]
			return
		end

		@participant = Participant.find(params[:id])

		if request.post?
			@participant.attributes = params[:participant]
			
			if can_access?('participant', 'participant_grade')
				@participant.participant_functionary_id = current_user.id
			elsif can_access?('participant', 'theme_grade')
				@participant.theme_functionary_id = current_user.id
			end

			if @participant.save
				if params[:commit] =~ /next/
					redirect_to :id => @participant.id + 1, 
						:page => params[:page]
				else
					redirect_to :action => 'browse', :page => params[:page]
				end
				return
			else
				flash[:warnings] = @participant.errors
			end
		end

		if can_access?('participant', 'participant_grade')
			render(:action => 'participant_grade')
		elsif can_access?('participant', 'theme_grade')
			render(:action => 'theme_grade')
		end
	end
	
	def update
		@countries = Country.find(:all, :order=>"name")
		@participant = Participant.find(params[:id])
	end

	def save
		@participant = Participant.find(params[:id])
		@participant.attributes = params[:participant]
		if @participant.save
   			redirect_to :action => "browse"
    	else
			redirect_to :action => "update", :id => @participant.id
      		flash[:warnings] = @participant.errors
		end
	end

	def build_browse_query
		@query = ""
		if params[:participant]
			@search_participant = Participant.new(params[:participant])
			
			p_id = @search_participant.id
			fornavn = @search_participant.first_name
			etternavn= @search_participant.last_name
			email = @search_participant.email
			sex = @search_participant.sex
			part_grade = @search_participant.participant_grade
			t_grade1 = @search_participant.theme_grade1
			t_grade2 = @search_participant.theme_grade2
			sex = @search_participant.sex
			final_workshop = @search_participant.final_workshop
			country = @search_participant.country_id
			#region = params[:region]
			#age = params[:age]
			invited = @search_participant.invited
			travel_apply = @search_participant.travel_apply
			travel_nosupport_cancome = @search_participant.travel_nosupport_cancome
			travel_assessed = params[:travel_assessed]
			travel_assigned = @search_participant.travel_assigned
			travel_required = params[:travel_required]
			travel_no_apply = params[:travel_no_apply]
			
			@query = ""
			if params[:participant][:id] != ""
				if @query == ""
				  @query = "participants.id = '#{params[:participant][:id]}'"
				else
				  @query += " AND participants.id = '#{params[:participant][:id]}'"
				end
			end
			if fornavn != ""
				if @query == ""
			   	@query = "first_name LIKE '%"+fornavn+"%'"
				else
				  @query += " AND first_name LIKE '%"+fornavn+"%'"
				end
			end
			if etternavn != ""
				if @query == ""
				  @query = "last_name LIKE '%"+etternavn+"%'"
				else
				  @query += " AND last_name LIKE '%"+etternavn+"%'"
				end
			end
			if email !=""
				if @query == ""
				@query = "email LIKE '%"+email+"%'"
				else
				@query += " AND email LIKE '%"+email+"%'"
				end
			end
			if part_grade != ""
				if @query == ""
				@query = "participant_grade >= '"+part_grade.to_s()+"'"
				else
				@query += " AND participant_grade >= '"+part_grade.to_s()+"'"
				end
			end
			if t_grade1 != ""
				if @query == ""
				@query = "ceil((theme_grade1+theme_grade2)/2) >= '"+t_grade1.to_s()+"'"
				else
				@query += " AND ceil((theme_grade1+theme_grade2)/2) >= '"+t_grade1.to_s()+"'"
				end
			end
			if t_grade2 != ""
				if @query == ""
				@query = "ceil(((theme_grade1+theme_grade2)/2)+participant_grade) >= '"+t_grade2.to_s()+"'"
				else
				@query += " AND ceil(((theme_grade1+theme_grade2)/2)+participant_grade) >= '"+t_grade2.to_s()+"'"
				end
			end
			if sex != ""
				if @query == ""
				@query = "sex = '"+sex+"'"
				else
				@query += " AND sex = '"+sex+"'"
				end
			end
			if final_workshop.to_s =~ /^\d+$/
				if @query == ""
				@query = "final_workshop = '"+final_workshop.to_s()+"'"
				else
				@query += " AND final_workshop = '"+final_workshop.to_s()+"'"
				end
			end
			if country != "" and country != -1
				if @query == ""
				@query = "country_id = '"+country.to_s()+"'"
				else
				@query += " AND country_id = '"+country.to_s()+"'"
				end
			end
			if invited != 0
				if @query == ""
				@query = "invited = '"+invited.to_s()+"'"
				else
				@query += " AND invited = '"+invited.to_s()+"'"
				end
			end
			if travel_apply != 0
				if @query == ""
				@query = "travel_apply = '"+travel_apply.to_s()+"'"
				else
				@query += " AND travel_apply = '"+travel_apply.to_s()+"'"
				end
			end
			if travel_no_apply != nil
				if @query == ""
				@query = "travel_apply = 0"
				else
				@query += " AND travel_apply = 0"
				end
			end
			if travel_nosupport_cancome != 0
				if @query == ""
				@query = "travel_apply = 1 AND travel_nosupport_cancome = '"+travel_nosupport_cancome.to_s()+"'"
				else
				@query += " AND travel_apply = 1 AND travel_nosupport_cancome = '"+travel_nosupport_cancome.to_s()+"'"
				end
			end
			if travel_assigned != 0
				if @query == ""
				@query = "travel_assigned = '"+travel_assigned.to_s()+"' and
					travel_assigned_amount > 0"
				else
				@query += " AND travel_assigned = '"+travel_assigned.to_s()+"'
					and travel_assigned_amount > 0"
				end
			end
			if travel_assessed != nil
				if @query == ""
				@query = "travel_assigned = '"+travel_assessed.to_s()+"'"
				else
				@query += " AND travel_assigned = '"+travel_assessed.to_s()+"'"
				end
			end
			if travel_required != nil
				if @query == ""
				@query = "travel_apply = 1 AND travel_nosupport_cancome = 0"
				else
				@query += " AND travel_apply = 1 AND travel_nosupport_cancome = 0"
				end
			end

			if params[:pg_less] =~ /.+/
				@query += " AND " if @query != ""
				@query += "participant_grade < " + params[:pg_less]
			end
			if params[:thg_less] =~ /.+/
				@query += " AND " if @query != ""
				@query += "ceil((theme_grade1 + theme_grade2) / 2) < " + params[:thg_less]
			end
			if params[:tg_less] =~ /.+/
				@query += " AND " if @query != ""
				@query += "(participant_grade + ceil((theme_grade1 + theme_grade2) / 2)) < " + params[:tg_less]
			end

			if params[:logged_in] != nil
				@query += " AND" if @query != ""
				@query += " not last_login is null"
			end
			if params[:not_logged_in] != nil
				@query += " AND" if @query != ""
				@query += " last_login is null"
			end
			
			if params[:answered] != nil
				@query += " AND" if @query != ""
				@query += " participants.id in (select a.id from answers a where a.id = participants.id)"
			end
			if params[:not_answered] != nil
				@query += " AND" if @query != ""
				@query += " participants.id not in (select a.id from answers a where a.id = participants.id)"
			end
			if params[:answered_yes] != nil
				@query += " AND" if @query != ""
				@query += " participants.id in (select a.id from answers a where a.id = participants.id and a.attend = 1)"
			end
			if params[:answered_no] != nil
				@query += " AND" if @query != ""
				@query += " participants.id in (select a.id from answers a where a.id = participants.id and a.attend = 0)"
			end
			if params[:travelinfo_registered] != nil
				@query += " AND" if @query != ""
				@query += " NOT arrival_date IS NULL"
			end
			if params[:travelinfo_not_registered] != nil
				@query += " AND" if @query != ""
				@query += " arrival_date IS NULL"
			end

			# Visa alternatives
			visa_query = "";
			if params[:visa_not_needed] != nil
				visa_query += " OR" if visa_query != ""
				visa_query += " visa = 'NO_NEED_OF_VISA'"
			end
			if params[:visa_not_processed] != nil
				visa_query += " OR" if visa_query != ""
				visa_query += " visa = 'APPLICATION_NOT_PROCESSED'"
			end
			if params[:visa_granted] != nil
				visa_query += " OR" if visa_query != ""
				visa_query += " visa = 'VISA_BEEN_GRANTED'"
			end
			if params[:visa_rejected] != nil
				visa_query += " OR" if visa_query != ""
				visa_query += " visa = 'VISA_BEEN_REJECTED'"
			end
			@query += " AND" if @query != "" and visa_query != ""
			@query += "(" + visa_query + ")" if visa_query != ""

			@query += "#{@query != "" ? " and " : ""} not checked_in is null" if params[:checkin].to_i == 1
			@query += "#{@query != "" ? " and " : ""} checked_in is null" if params[:checkin].to_i == 2

		end

	end

	def browse
		@can_invite = can_access?("participant", "invite")
		@can_see_password = can_access?("participant", "show_passwords")

		if request.post? and params[:invites]
			invites = params[:invites]

			invites.each do |id,invite|
				p = Participant.find(id)
				p.invited = invite
				p.save!
			end
		end

		build_browse_query

		#if params[:invite_all] == "true"
		#	Participant.update_all("invited = 1", @query)
		#elsif params[:uninvite_all]
		#	Participant.update_all("invited = 0", @query)
		#end

		sort_init 'participants.id'
		sort_update

		@participants = Participant.paginate(:page => params[:page], 
			:order => sort_clause, :include => [:country],
			:conditions => "#{@query}", :joins => "left outer join answers a on a.id = participants.id")
			#:conditions => "#{@query}#{@view_cond}")
	end
	
	def statistics
		if params[:id] == "region"
			@query = build_query(params[:participant])
			#@participants = Participant.count(:all, :include => ["country"], :group=>"region_id", :conditions => "#{@query}")
			@query = "WHERE " + @query if @query != ''
			@participants = Participant.find_by_sql("select r.name as region_name, count(*) as count, 
				sum(p.travel_assigned_amount) as amount from participants p inner join countries c on 
				p.country_id = c.id inner join regions r on c.region_id = r.id left outer join answers a on a.id = p.id #{@query} group by r.id order by c.name")
			@total = Participant.count_by_sql "SELECT COUNT(*) FROM participants left outer join answers a on a.id = participants.id  #{@query}"  
			@total_amount = Participant.count_by_sql "SELECT sum(travel_assigned_amount) FROM participants left outer join answers a on a.id = participants.id  #{@query}"  
		elsif params[:id] == "gender"
			@genders = {"f" => "Female", "m" => "Male"}
			@query = build_query(params[:participant])
			@participants = Participant.count(:all, :group=>"sex", :conditions => "#{@query}", :joins => "left outer join answers a on a.id = participants.id")
			@query = "WHERE " + @query if @query != ''
			@total = Participant.count_by_sql "SELECT COUNT(*) FROM participants left outer join answers a on a.id = participants.id  #{@query}"  
		elsif params[:id] == "age"
			@query = build_query(params[:participant])
			@participants = Participant.count(:all, :group=>"year(now())-year(birthdate)", :conditions => "#{@query}", :joins => "left outer join answers a on a.id = participants.id")
			@query = "WHERE " + @query if @query != ''
			@total = Participant.count_by_sql "SELECT COUNT(*) FROM participants left outer join answers a on a.id = participants.id  #{@query}"	
	 	elsif params[:id] == "ws"
		  	@workshops = Workshop.find(:all)
			@query = build_query(params[:participant])
			@participants1 = Participant.count(:all, :group=>"workshop1", :conditions => "#{@query}", :joins => "left outer join answers a on a.id = participants.id")  
			@participants2 = Participant.count(:all, :group=>"workshop2", :conditions => "#{@query}", :joins => "left outer join answers a on a.id = participants.id")
			@participants3 = Participant.count(:all, :group=>"final_workshop", :conditions => "#{@query}", :joins => "left outer join answers a on a.id = participants.id")
			@query = "WHERE " + @query if @query != ''
			@total = Participant.count_by_sql "SELECT COUNT(*) FROM participants left outer join answers a on a.id = participants.id #{@query}"
		else
		  	@countries = Country.find(:all)
			@query = build_query(params[:participant])
			#@participants = Participant.count(:all, :group=>"country_id", :conditions => "#{@query}")
			@query = "WHERE " + @query if @query != ''
			@participants = Participant.find_by_sql("select c.name as country_name, count(*) as count, 
				sum(p.travel_assigned_amount) as amount from participants p inner join countries c on 
				p.country_id = c.id left outer join answers a on a.id = p.id #{@query} group by c.id order by c.name")
			@total = Participant.count_by_sql "SELECT COUNT(*) FROM 
				participants left outer join answers a on a.id = participants.id  #{@query}"
			@total_amount = Participant.count_by_sql "SELECT sum(travel_assigned_amount) FROM participants left outer join answers a on a.id = participants.id  #{@query}"  
		end
	end
  
  def build_query(participant_params)
    #search_participant = Participant.new(participant_params)
	search_participant = params[:participant] != nil ? params[:participant] : {}
    part_grade = search_participant[:participant_grade]
    t_grade1 = search_participant[:theme_grade1]
    t_grade2 = search_participant[:theme_grade2]
    invited = search_participant[:invited]
    attend = params[:attend]
    travel_assessed = params[:travel_assessed]
    travel_assigned = search_participant[:travel_assigned]
    travel_apply = search_participant[:travel_apply]
    travel_nosupport_cancome = search_participant[:travel_nosupport_cancome]
    travel_required = params[:travel_required]
    travel_no_apply = params[:travel_no_apply]
    
    query = ""
    if part_grade != nil and part_grade != ""
      if query == ""
        query = "participant_grade >= '"+part_grade.to_s()+"'"
      else
        query += " AND participant_grade >= '"+part_grade.to_s()+"'"
      end
    end
    if t_grade1 != nil and t_grade1 != ""
      if query == ""
        query = t_grade1.to_s + "ceil((theme_grade1+theme_grade2)/2) >= '"+t_grade1.to_s()+"'"
      else
        query += " AND ceil((theme_grade1+theme_grade2)/2) >= '"+t_grade1.to_s()+"'"
      end
    end
    if t_grade2 != nil and t_grade2 != ""
      if query == ""
        query = "ceil(((theme_grade1+theme_grade2)/2)+participant_grade) >= '"+t_grade2.to_s()+"'"
      else
        query += " AND ceil(((theme_grade1+theme_grade2)/2)+participant_grade) >= '"+t_grade2.to_s()+"'"
      end
    end
    if invited != nil and invited != "0"
      if query == ""
        query = "invited = '"+invited.to_s()+"'"
      else
        query += " AND invited = '"+invited.to_s()+"'"
      end
    end
   if attend != nil and attend != "0"
		if query == ""
		query = "attend = '"+attend.to_s()+"'"
		else
		query += " AND attend = '"+attend.to_s()+"'"
		end
	end
	if travel_apply != nil and travel_apply != "0"
		if query == ""
		query = "travel_apply = '"+travel_apply.to_s()+"'"
		else
		query += " AND travel_apply = '"+travel_apply.to_s()+"'"
		end
	end
	if travel_no_apply != nil and travel_no_apply != "0"
		if query == ""
		query = "travel_apply = 0"
		else
		query += " AND travel_apply = 0"
		end
	end
	if travel_nosupport_cancome != nil and travel_nosupport_cancome != "0"
		if query == ""
		query = "travel_apply = 1 AND travel_nosupport_cancome = '"+travel_nosupport_cancome.to_s()+"'"
		else
		query += " AND travel_apply = 1 AND travel_nosupport_cancome = '"+travel_nosupport_cancome.to_s()+"'"
		end
	end
	if travel_assigned != nil and travel_assigned != "0"
		if query == ""
		query = "travel_assigned = '"+travel_assigned.to_s()+"' and 
			travel_assigned_amount > 0"
		else
		query += " AND travel_assigned = '"+travel_assigned.to_s()+"' and
			travel_assigned_amount > 0"
		end
	end
	if travel_assessed != nil and travel_assessed != "0"
		if query == ""
		query = "travel_assigned = '"+travel_assessed.to_s()+"'"
		else
		query += " AND travel_assigned = '"+travel_assessed.to_s()+"'"
		end
	end
	if travel_required != nil and travel_required != "0"
		if query == ""
		query = "travel_apply = 1 AND travel_nosupport_cancome = 0"
		else
		query += " AND travel_apply = 1 AND travel_nosupport_cancome = 0"
		end
	end

			if params[:pg_less] =~ /.+/
				query += " AND " if query != ""
				query += "participant_grade < " + params[:pg_less]
			end
			if params[:thg_less] =~ /.+/
				query += " AND " if query != ""
				query += "ceil((theme_grade1 + theme_grade2) / 2) < " + params[:thg_less]
			end
			if params[:tg_less] =~ /.+/
				query += " AND " if query != ""
				query += "(participant_grade + ceil((theme_grade1 + theme_grade2) / 2)) < " + params[:tg_less]
			end
			if params[:travelinfo_registered] != nil
				query += " AND" if query != ""
				query += " NOT arrival_date IS NULL"
			end
			if params[:travelinfo_not_registered] != nil
				query += " AND" if query != ""
				query += " arrival_date IS NULL"
			end

	# Visa alternatives
	visa_query = "";
	if params[:visa_not_needed] != nil
		visa_query += " OR" if visa_query != ""
		visa_query += " visa = 'NO_NEED_OF_VISA'"
	end
	if params[:visa_not_processed] != nil
		visa_query += " OR" if visa_query != ""
		visa_query += " visa = 'APPLICATION_NOT_PROCESSED'"
	end
	if params[:visa_granted] != nil
		visa_query += " OR" if visa_query != ""
		visa_query += " visa = 'VISA_BEEN_GRANTED'"
	end
	if params[:visa_rejected] != nil
		visa_query += " OR" if visa_query != ""
		visa_query += " visa = 'VISA_BEEN_REJECTED'"
	end
	query += " AND" if query != "" and visa_query != ""
	query += "(" + visa_query + ")" if visa_query != ""

			query += "#{query != "" ? " and " : ""} not checked_in is null" if params[:checkin].to_i == 1
			query += "#{query != "" ? " and " : ""} checked_in is null" if params[:checkin].to_i == 2

	# Special-case queries (overrides previous query parameters)

	if params[:safe_ones] == '1'
		query = "invited = 1 AND (travel_apply = 0 OR 
			(travel_assigned = 1 AND travel_assigned_amount > 0))"
	elsif params[:safe_ones_and_maybes] == '1'
		query = "invited = 1 AND ((travel_apply = 0 OR
			(travel_assigned = 1 AND travel_assigned_amount > 0)) OR
			travel_nosupport_cancome = 1)"
	end

    query
  end
  
  def arrivals_and_departures
    sort_init 'arrival_place'
		sort_update
    
    if !params[:trip]
      #setter params[:trip] default til arrival
      params[:trip]= "arrival"
    end
    
    filter = ""
    if params[:tr] == "all"
    else
      filter += "arrival_carrier = '#{params[:tr]}' and " if params[:tr]  
    end
	  
	  
	  if params[:pl] == "all"
	    
    else
  	  if params[:pl] == "other"
  	    filter += "#{params[:trip]}_place not like 'trd' and #{params[:trip]}_place not like 'osl' and " 
      else
    	  filter += "#{params[:trip]}_place = '#{params[:pl]}' and " if params[:pl]
      end
    end
    
    if params[:date] == "all"
    else
      if params[:date] == "other"
        if params[:trip]=="arrival"
          filter += "arrival_date not like '2009-02-18' and "
          filter += "arrival_date not like '2009-02-19' and "
          filter += "arrival_date not like '2009-02-20' and "
        else
          filter += "departure_date not like '2009-03-01' and "
          filter += "departure_date not like '2009-03-02' and "
          filter += "departure_date not like '2009-03-03' and "
        end
      else
        if params[:trip]=="arrival"
          filter += "arrival_date like '2009-02-#{params[:date]}' and " if params[:date]
        else
          filter += "departure_date like '2009-03-0#{params[:date]}' and " if params[:date]
        end
      end
    end
    
    
		filter += "(visa = 'NO_NEED_OF_VISA' or visa = 'VISA_BEEN_GRANTED') and " if
			params[:visa].to_i == 1 
		filter += "(visa = 'APPLICATION_NOT_PROCESSED' or visa = 'VISA_BEN_REJECTED') and " if
			params[:visa].to_i == 2

		filter += "not checked_in is null and " if params[:checkin].to_i == 1
		filter += "checked_in is null and " if params[:checkin].to_i == 2
			
	  @count = Participant.count(:conditions =>
			"#{filter} invited = 1 and not #{params[:trip]}_date is null and attend = 1",
			:include => :country, :joins => 'left outer join answers on answers.id =
			participants.id')
		@per_page = params[:per_page] ? params[:per_page].to_i : 20
		
    if @per_page != 0
			@arrivals = Participant.paginate(:page => params[:page], 
				:order => sort_clause,:per_page => @per_page, :conditions =>
				"#{filter} invited = 1 and not #{params[:trip]}_date is null and attend = 1",
				:include => :country, :joins => 'left outer join answers on answers.id =
				participants.id')
		else
			@arrivals = Participant.find(:all, :order => sort_clause, :conditions =>
				"#{filter} invited = 1 and not #{params[:trip]}_date is null and attend = 1",
				:include => :country, :joins => 'left outer join answers on answers.id =
				participants.id')
		end    
  end
  
  def accommodation
  sort_init 'id'
  sort_update
    
    @count_bed = Participant.count_beds
    @count_bed_first = Participant.count_beds_first
    @count_bed_second = Participant.count_beds_second
    @count_bedding = Participant.count_beddings
    
    @per_page = params[:per_page] ? params[:per_page].to_i : 30
    
    if @per_page != 0
			@participants = Participant.paginate(:page => params[:page], 
				:order => sort_clause,:per_page => @per_page, :conditions => "bed>0")
		else
			@participants = Participant.find(:all, :order => sort_clause, :conditions =>
				"bed>0")
		end
    
  end       
end         
            
