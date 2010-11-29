class WatchLog<ActiveRecord::Base
  validates_presence_of :logged_by, :message => "You must write who this is logged by."
  validates_presence_of :start_time, :message => "You have to provide the start time of the watch"
  validates_presence_of :end_time, :message => "You have to provide the end time of the watch"
  validates_presence_of :watching_functionary, :message => "You have to provide the watching functionary"
end