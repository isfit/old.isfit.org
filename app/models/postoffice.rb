#encoding: utf-8
class Postoffice < ActionMailer::Base
  # located in models/postoffice.rb
  # make note of the headers, content type, and time sent
  # these help prevent your email from being flagged as spam
  default :from => "ISFiT 2015 <no-reply@isfit.org>"
  def registered(name, email)
    @recipients   = email
    @subject      = "Application registered"
    @sent_on      = Time.now
    @content_type = "text/plain"

    @name  = name
    @email = email
    mail(:to => email, :subject => "Application registered")
  end

  def press_acc(id)
    @recipients   = "boxaspen@isfit.org"
    @subject      = "Ny presseakkreditering"
    @sent_on      = Time.now
    @content_type = "text/plain"
	@press_accreditation = PressAccreditation.find(id)
	
	mail(:to => @recipients, :subject => @subject)

  end

  def fund(application, files, mails)
    #@recipients   = "leader.stiftelsen@isfit.org"
    @recipients   = mails
    @from         = "ISFiT 2011 <noreply@isfit.org>"
    @subject      = "New application for ISFiT funds"
    @sent_on      = Time.now
    @content_type = "text/html"


    body[:name]                   = application.name
    body[:initiator]              = application.initiator
    body[:email]                  = application.email
    body[:address]                = application.address
    body[:country]                = application.country
    body[:phone]                  = application.phone
    body[:isfit_connection]       = application.isfit_connection
    body[:isfit_connection_year]  = application.isfit_connection_year
    body[:amount]                 = application.amount
    body[:account_details]        = application.account_details
    body[:purpose_text]           = application.purpose_text
    body[:plans_text]             = application.plans_text
    body[:further_funding_plan]   = application.further_funding_plan
    body[:other_info]             = application.other_info


    # attach files
    files.each do |file|
      attachment "application/octet-stream" do |a|
        a.filename = file.original_filename
        a.body = file.read
      end unless file.blank?
    end
  end

  def host_add(mails)
    @recipients   = mails
    @from         = "ISFiT 2013 <verter@isfit.org>"
    @subject_en   = "Thank you for applying as an ISFiT host"
    @subject_no   = "Takk for at du meldte deg som ISFiT-vert"
    @sent_on      = Time.now
    @content_type = "text/html"
    if I18n.locale.to_s == "no"
  	  mail(:from => @from, :to => @recipients, :subject => @subject_no)
    else
      mail(:from => @from, :to => @recipients, :subject => @subject_en)
    end  
  end

  def applicant_add(name, email)
    @recipients   = email
    @subject      = "ISFiT 2015"
    @sent_on      = Time.now
    @content_type = "text/html"

    @name  = name
    @email = email
    mail(:to => email, :subject => @subject)
  end

  def applicant_add_with_new_user(name, email, password)
    @recipients   = email
    @subject      = "ISFiT 2015"
    @sent_on      = Time.now
    @content_type = "text/html"

    @name     = name
    @email    = email
    @password = password
    mail(to: @email, subject: @subject)
  end

  def new_applicant_user(email, password)
    @recipients   = email
    @subject      = "Søker ISFiT 2015"
    @sent_on      = Time.now
    @content_type = "text/html"

    @email    = email
    @password = password

    mail(to: @recipients, subject: @subject)
  end

  def new_password(email, password)
    @recipients   = email
    @subject      = "Nytt passord til isfit.org"
    @sent_on      = Time.now
    @content_type = "text/html"

    @password = password

    mail(to: @recipients, subject: @subject)
  end

  def subscription_mailing_list(email)
    @recipients     = email
    @from           = "no-reply@isfit.org"
    @subject        = "[ISFiT] subscription registered"
    @sent_on        = Time.now
    @content_type   = "text/html"
    
    mail(:from => @from, :to => @recipients, :subject => @subject) 
  end

  def donation(name, email)
    @recipients     = email
    @from           = "kari.strandjord@isfit.org"
    @subject_en     = "Thank you for your contribution!"
    @subject_no     = "Tusen takk for ditt bidrag!"
    @sent_on        = Time.now
    @content_type   = "text/html"
    attachments["julebrev.pdf"] = File.read(Rails.root.join("public", "Julebrev.pdf"))
    if I18n.locale.to_s == "no"
      mail(:from => @from, :to => @recipients, :subject => @subject_no) 
    else
      mail(:from => @from, :to => @recipients, :subject => @subject_en) 
    end
  end
end
