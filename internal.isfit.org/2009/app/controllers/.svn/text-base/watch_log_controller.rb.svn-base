class WatchLogController<ApplicationController
  helper :sort
  include SortHelper
  
  
  def index
    sort_init 'start_time', :default_order => 'desc'
		sort_update
    
    @watch_logs = WatchLog.paginate(:page => params[:page], :order => sort_clause, :conditions => "deleted = 0", :per_page => 20)
  end
  
  def view
    @watch_log = WatchLog.find_by_id(params[:id])    
  end
  
  def create
    CalendarDateSelect.format = :iso_date
    
    if request.post?
      if params[:id]
        @watch_log = WatchLog.find(params[:id], :conditions => "deleted = 0")
        @watch_log.attributes = params[:watch_log]
      else
        # Fetch the posted parameters and create a new watch log object.
        @watch_log = WatchLog.new(params[:watch_log])
      end      
      if @watch_log.save
        redirect_to :action => "index"
      else
        flash[:warnings] = @watch_log.errors
        #Do something
      end
    else
      if params[:id]
        @watch_log = WatchLog.find(params[:id], :conditions => "deleted = 0")
      end
    end
  end

  def delete
    watch_log = WatchLog.find(params[:id])
    watch_log.deleted = 1
    watch_log.save
    redirect_to :action => "index"
  end

end