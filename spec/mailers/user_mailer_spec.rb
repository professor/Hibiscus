require "spec_helper"

describe UserMailer do
  before do
    @user = FactoryGirl.build(:user)
    @articles = {}
    @posts = {}
    @email = UserMailer.article_email(@user, @articles)
    @weekly_email = UserMailer.weekly_email(@user)
  end

  #ensure that the subject is correct
  it 'renders the subject' do
    @email.subject.should == 'Article Feeds Notification'
  end

  #ensure that the receiver is correct
  it 'renders the receiver email' do
    @email.to.should == [@user.email]
  end

  #ensure that the sender is correct
  it 'renders the sender email' do
    @email.from.should == ['noreply@sv.cmu.edu']
  end

  #ensure that the @user.name variable appears in the email body
  it 'assigns @user.name' do
    @email.body.encoded.should match(@user.name)
  end

  #ensure that the @url variable appears in the email body
  it 'assigns @url' do
    @email.body.encoded.should match("http://craftsmanship.sv.cmu.edu")
  end

  #ensure that the subject is correct
  it 'renders the subject' do
    @weekly_email.subject.should == 'CMU Craftsmanship Weekly Digest'
  end

  #ensure that the sender is correct
  it 'renders the sender email' do
    @weekly_email.from.should == ['noreply@sv.cmu.edu']
  end

  #ensure that the @url variable appears in the email body
  it 'assigns @url' do
    @weekly_email.body.encoded.should match("http://craftsmanship.sv.cmu.edu")
  end
end
