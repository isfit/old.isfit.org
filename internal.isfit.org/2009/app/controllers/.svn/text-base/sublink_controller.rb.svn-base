class SublinkController < ApplicationController
  #fiks dette på annen måte, finnes tabell i databasen!!!
 	$categories = [['Contact',2], ['Programme',3], ['Background',4] , ['The experience',5], ['Links',6], ['Apply',7]]
 	$lookupadr= [[0],['contact'],['programme'], ['background'] , ['experience'], ['links'], ['apply']]
  def index 
      @tabs = Tab.find(:all)
  end
  
  def self.create_linklist
    links = []
		links.push(["Choose link...",nil])
		Tab.find(:all).each do |link|
			links.push([link.name_en.capitalize, nil])
			Sublink.find(:all, :conditions => {:tab_id => link.id, :deleted =>0 }, :order => "`order`").each do |sublink|
				links.push([" -> #{sublink.title_en}", sublink.id])
			end
		end
    # $categories.each do |link|
    #   links.push([link[0], nil])
    #   SublinkController.get_sublinks(link[1]).each do |sublink|
    #         #         urlstring = "#{link[0].downcase}-"+"#{sublink.title_en.tr(' ','-').downcase}"
    #         # links.push([" -> #{sublink.title_en}", urlstring])
    #     links.push([" -> #{sublink.title_en}", sublink.id])
    #   end
    # end
    links
  end
  
  
  def create
    @links = SublinkController.create_linklist

    if request.post?
      if params[:id]
        @sublink = Sublink.find(params[:id])
        @sublink.attributes = params[:sublink]
      else
        @sublink = Sublink.new(params[:sublink])
      end


      if @sublink.external_url.blank?
         @sublink.external_url = nil
      end

      
      #Metode som flytter elementer pa posisjon >=i ett hakk opp hvis
      #ny link har order=i. 
      links = SublinkController.get_sublinks(@sublink.tab_id)
      flag = 0
      links.each do |l|
        unless l.id == @sublink.id
          if l.order == @sublink.order and flag == 0
            flag = 1
          end
          if flag ==1
            s_link = Sublink.find(l.id)
            s_link.order =s_link.order+ 1
            s_link.save
          end
        end
      end
      
      

      if @sublink.save
        #Funksjon for aa sikre at linkene har etterfolgende nummer
        i=0
        links = SublinkController.get_sublinks(@sublink.tab_id)
        links.each do |l|
          s_link = Sublink.find(l.id)
          s_link.order =i
          s_link.save
          i=i+1
        end
        redirect_to :action => "index"
      else
        flash[:warnings] = @sublink.errors
      end
    else
      if params[:id]
        @sublink = Sublink.find(params[:id])
      else
        $curr_cat = 0
      end
    end
    
  end
  
  def delete
    s = Sublink.find(params[:id])
    s.delete
    redirect_to :action => "index"
    
  end
  
  def self.get_sublinks(category)
    c = Sublink.find(:all, :conditions => {:tab_id => category, :deleted =>0 }, :order => "`order`")
  end
  
  def view_sublinks
    @subcategories = SublinkController.get_sublinks(params[:tab_id])
    $curr_cat = params[:tab_id].to_i
  end
  
  def self.get_order(category)
    @order= Array.new(11) {|i| i}
  end
  
  # def toggle_external_link_field
  #   if params[:url].to_i == 1000
  #     $show_external_link = true
  #   else
  #     $show_external_link = false
  #   end
  # end
  
end
