class StatsController < ApplicationController

http_basic_authenticate_with :name => "ambassadors", :password => "thisisasecretpassword"

  def index
    @participants_per_day = Participant.count(:group => "date(registered_time)")
    @participants_gender = Participant.group("sex").count
    @participants_age = Participant.count(:group => "year(birthdate)")
    @workshops = Workshop.all
    @country_count = Participant.group("country_id").count
    @workshop1_count = Participant.group("workshop1").count
    @workshop2_count = Participant.group("workshop2").count
    @workshop3_count = Participant.group("workshop3").count
    @countries = Country.where("code IS NOT NULL")
    @sum = 0
    @sum_expected = 0
  end

end