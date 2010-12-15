require 'rubygems'
require 'postgres'

  
class Sweater
  #@@database = "mdb2_dev"
  #@@user = "billig_isfit"
  #@@password = "Quaeg%ei8"
  @@database = "mdb2"
  @@user = "billig_isfit"
  @@password = "Quaeg%ei8"


  def self.each(&block)
    # Connect to database
    conn = PGconn.connect("sql.samfundet.no", 5432, '', '', "#{@@database}", "#{@@user}", "#{@@password}")
    res = conn.exec("select * from isfit_events where sale_to > now() order by event, price_group")
    conn.close 
    res.each do |r|
      h = {}
      i = 0
      res.fields.each do |f|
        h[f] = r[i]
        i += 1
      end
      yield h
    end
  end

  def self.create_single_purchase(email, price_group, count)
    conn = PGconn.connect("sql.samfundet.no", 5432, '', '', "#{@@database}", "#{@@user}", "#{@@password}")
    ret = conn.exec("select * from isfit_create_purchase(NULL, '#{email}', '{{#{price_group},#{count}}}')")
	conn.close
	ret[0]
  end
  def self.create_single_purchase_member(card_id, price_group, count)
    conn = PGconn.connect("sql.samfundet.no", 5432, '', '', "#{@@database}", "#{@@user}", "#{@@password}")
	res = conn.exec("SELECT owner_member_id FROM ticket_card WHERE card = '#{card_id}'")	
	member_id = res[0]
    ret = conn.exec("select * from isfit_create_purchase('#{member_id}', NULL, '{{#{price_group},#{count}}}')")
	conn.close
	ret[0]
  end

  def self.payneturl(purchase_id, sum, pmd)
	#Test-paynet
     #shop_id 	= '00000001'
     #subshop_id 	= '0026'
    #End test
	
	# Production paynet
	shop_id  	= '48872'
	subshop_id	= '0001'

    "https://www.paynet.no/term193/terminal.php?ttype=sale&id=#{shop_id}&subid=#{subshop_id}&currency=NOK&utref=#{purchase_id}&amount=#{sum}&desc=Salg av isfit-genser.&PMD=#{pmd}"
  end

  
  def self.purchase_status(pmd)
	pmd = pmd[0,7]
    conn = PGconn.connect("sql.samfundet.no", 5432, '', '', "#{@@database}", "#{@@user}", "#{@@password}")
    ret = conn.exec("SELECT paid, timed_out	FROM purchase  NATURAL JOIN ticket	WHERE ticket = #{pmd}")
	conn.close
	ret[0]
	#testing
    #tull = ["2006-08-14 23:08:48.107701",nil]
  end
  def self.sweater_info(price_group)
    conn = PGconn.connect("sql.samfundet.no", 5432, '', '', "#{@@database}", "#{@@user}", "#{@@password}")
    ret = conn.exec("SELECT event_name,price_group_name	FROM isfit_events where price_group = #{price_group}")
	conn.close
	res = ret[0]
	res[0] +"("+res[1]+")"
	
	#testing
    #tull = ["2006-08-14 23:08:48.107701",nil]
  end
end
