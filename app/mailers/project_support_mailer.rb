class ProjectSupportMailer < ActionMailer::Base
  default :from => "post-isfit@isfit.org"
  default :to => "post-isfit@isfit.org"

  def verification_mail(mail_address)
    @mail_address = mail_address
    mail(:to => mail_address, :subject => "Post-ISFiT Grants: Your application has been received")
  end

  def application_mail(project_support)
    @project_support = project_support
    mail(:subject => "[Post-ISFiT Grants] Application from " + @project_support.person_mail)
  end
end
