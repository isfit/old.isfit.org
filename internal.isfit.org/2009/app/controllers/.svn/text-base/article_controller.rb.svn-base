class ArticleController < ApplicationController
    class Helper
        include Singleton
        include ActionView::Helpers::TextHelper
    end

	def index
    # Fetch all articles that are not deleted
    news_articles =  Article.find(:all,:conditions => "`deleted` = 0", :order => '(sticky = 1 AND end_at > now()) DESC , created_at DESC')
    
    articles = []
    
    
    
    #Filter out only the one visible for this user
    news_articles.each do |article|
      

      if ArticleController.has_access?(article, current_user)
          articles.push(article)
      end
      
    end
    
    @articles = articles.paginate(:page => params[:page], :per_page => 10)
	  #@news_articles = Article.find(:all, :conditions => "`deleted` = 0",:order => "created_at desc") 
	
	# Birthday stuff!
	@users = LdapUser.search("ou=isfit09,ou=units,dc=isfit,dc=org", true, "objectClass=inetOrgPerson", 
			["sn", "dateofbirth", "givenname"])
				
	@users = @users.delete_if do |x|
		x.firstname == nil || x.date_of_birth == nil || x.lastname == nil
	end
			
	@users = @users.sort do |a,b|
			
		if (a.lastname <=> b.lastname) == 0
			a.firstname <=> b.firstname
		else
			a.lastname <=> b.lastname
		end
	end
  end
  
  def self.has_access?(article, current_user)
    
    #create an array of the dn values (separted by ldap with ",")
    article_dn = article.group_dn.split(",")
    # find matching ou element at the user's dn-list (i.e. traverse backwards the length of the article dn-list)  
    user_credentials = current_user.dn.split(",")[-(article_dn.length)]

    if article_dn[0] == user_credentials or article.user_id == current_user.id or current_user.is_in_group?(article.group_dn)
        return true
    else
      return false
    end
  end
  
  def self.test(link) 
    '<a href="'+link+'">'+link+'</a>'
  end   
  
  def show
    if params[:id] and ArticleController.has_access?(Article.find(params[:id]), current_user)
      @article = Article.find(params[:id])
   else
      redirect_to :action => "index"
    end
    
  end
  
  def create
      CalendarDateSelect.format = :iso_date
      @user_units = LdapUnit.get_by_dn("ou=isfit09,ou=units,dc=isfit,dc=org").units      
      @units = []
			@units.push(["Everyone","ou=isfit09,ou=units,dc=isfit,dc=org"])
			@user_units.each do |unit|
				@units.push([unit.description, unit.dn])
				unit.units.each do |subunit|
					@units.push([" -> #{subunit.description}", subunit.dn])
				end
			end
      
			
    if request.post?
      
      if params[:id]
        @article = Article.find(params[:id])
        @article.attributes = params[:article]
      else
        # Fetch the posted parameters and create a new article object.
        @article = Article.new(params[:article])  
        @article.user_id = current_user.id
      end
      if @article.save
        unless params[:image] == ""
    				path = "#{RAILS_ROOT}/public/images/article_images/" +
    					"#{@article.id}.jpg"
    				@picture = Picture.new(path, params[:image],400)
    				@picture.save
    			end
        redirect_to :action => "index"
      else
        flash[:warnings] = @article.errors
        #Do something
      end
    else
      if params[:id]
        if Article.find(params[:id]).user_id != current_user.id
          redirect_to :action => "index"
        end
        @article = Article.find(params[:id])
      end
    end
    
  end
  
  
  def delete
    if params[:id] and Article.find(params[:id]).user_id == current_user.id
      article = Article.find(params[:id])
      article.deleted = 1
      article.save
    end
    redirect_to :action => "index"
  end
end
