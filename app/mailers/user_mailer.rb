class UserMailer < ActionMailer::Base
  default :from => "john.lee@sv.cmu.edu"


  def article_email(user)
    @user = user
    @url  = "http://craftsmanship.sv.cmu.edu"
    mail(:to => user.email, :subject => "Article Feeds Notification")
  end
end
