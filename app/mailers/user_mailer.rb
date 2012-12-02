# User Mailer extends ActionMailer for sending email notifications.

class UserMailer < ActionMailer::Base
  default :from => "noreply@sv.cmu.edu"


  ##
  # Send email of new articles to admin user.
  # Invoked from Article.get_feeds
  ##
  def article_email(user, articles)
    @user = user
    @url  = "http://craftsmanship.sv.cmu.edu"
    #@url  = "http://127.0.0.1:3000"
    @articles = articles
    mail(:to => user.email, :subject => "Article Feeds Notification")
  end


  ##
  # Send weekly digest to users that agree to notification.
  # Invoked from Article.deliver_weekly_digest
  ##
  def weekly_email(user)
    @url  = "http://craftsmanship.sv.cmu.edu"
    @posts = Post.desc(:created_at).limit(8)
    @id = user.id.to_s

    mail(:to => user.email, :subject => "CMU Craftsmanship Weekly Digest")
  end
end
