class ApplicantController < ApplicationController

	helper :sort
	include SortHelper

	def interviews
		@applicants = Applicant.find_by_sql("
			select *, interview_place_1 as place, interview_time_1 as time 
				from applicants where
				interviewer_id_1_1 = #{current_user.id} UNION
			select *, interview_place_1 as place, interview_time_1 as time 
				from applicants where
				interviewer_id_1_2 = #{current_user.id}")
	end

	def show
		@applicant = Applicant.find(params[:id])

		@status = {	0 => 'Not contacted',
					1 => 'Meeting planned',
					2 => 'Meeting done',
					3 => 'Of interest',
					4 => 'Recruited',
					5 => 'Not of interest' }
	end

	def edit
		@applicant = Applicant.find(params[:id])
		@sections = Section.find(:all, :order => "name_no asc")

		@status = {	0 => 'Not contacted',
					1 => 'Meeting planned',
					2 => 'Meeting done',
					3 => 'Of interest',
					4 => 'Recruited',
					5 => 'Not of interest' }

		@functionaries = 
			LdapUnit.get_by_dn("ou=isfit09,ou=units," \
			"dc=isfit,dc=org").functionaries(true)
		nobody = LdapUser.new({})
		nobody.lastname = "<Not set"
		nobody.firstname = "yet>"
		nobody.id = -1
		@functionaries.insert(0, nobody)

		if request.post?
			@applicant.attributes = params[:applicant]
			@applicant.position_id_1 = params[:first]
			@applicant.position_id_2 = params[:second]
			@applicant.position_id_3 = params[:third]

			if @applicant.save
				redirect_to :action => 'browse'
			end
		end
	end

	def browse
		sort_init 'applicants.id'
		sort_update

		leader_joins = "
			left outer join positions p1 
				on p1.id = applicants.position_id_1
			left outer join sections on sections.id = p1.section_id
			left outer join positions p2
				on p2.id = applicants.position_id_2
			left outer join positions p3
				on p3.id = applicants.position_id_3"

		leader_conditions = "
			p1.group_dn = \"#{current_user.unit.dn}\" or
			p2.group_dn = \"#{current_user.unit.dn}\" or
			p3.group_dn = \"#{current_user.unit.dn}\""

		recruiting_joins = "
			left outer join positions p1 
				on p1.id = applicants.position_id_1
			left outer join sections on sections.id = p1.section_id"
		
		assistant_conditions = "
			p1.group_dn like \"%#{current_user.unit.parent.dn}\" or
			p2.group_dn like \"%#{current_user.unit.parent.dn}\" or
			p3.group_dn like \"%#{current_user.unit.parent.dn}\""

		@recruiting = can_access?('applicant', 'browse_all')
		
		assistant = current_user.unit.name == "board"

		@applicants = Applicant.paginate(:page => params[:page], 
			:order => sort_clause, :include => [:first_position,
			:second_position, :third_position], 
			:joins => @recruiting ?
				recruiting_joins : leader_joins,
			:conditions => @recruiting ? "" : (assistant ? 
				assistant_conditions : leader_conditions))

		@status = {	0 => 'Not contacted',
					1 => 'Meeting planned',
					2 => 'Meeting done',
					3 => 'Of interest',
					4 => 'Recruited',
					5 => 'Not of interest' }
	end

end
