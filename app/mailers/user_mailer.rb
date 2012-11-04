class UserMailer < ActionMailer::Base
  default :from => "noreply@sv.cmu.edu"


  def article_email(user, articles)
    @user = user
    @url  = "http://craftsmanship.sv.cmu.edu"
    @articles = articles
    mail(:to => user.email, :subject => "Article Feeds Notification")
  end
end
