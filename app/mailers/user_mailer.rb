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
  def weekly_email(frequency = "Weekly")

    @url  = "http://craftsmanship.sv.cmu.edu"
    @bcc = ""

    User.where(:digest_frequency => frequency).each do | u |
      @bcc += u.email + ","
    end

    @bcc = @bcc[0..-1]

    @message_subject = "CMU Craftsmanship #{frequency.capitalize} Digest"
    @posts = Post.desc(:created_at).limit(8)

    mail(:bcc => @bcc, :subject => @message_subject)
  end
end
