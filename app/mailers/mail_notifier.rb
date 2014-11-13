class MailNotifier < ActionMailer::Base
  default from: "nolegendhere@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mail_notifier.registered.subject
  #
  def registered(user)
    @user = user
    mail to: user.email, subject: 'Registration confirmation'
  end


  def self.send_follow_email(subscriptions, post)
     #@subscriptions = subscriptions.collect(&:email).join(",")
     @subscriptions=subscriptions.pluck(:email)
     @subscriptions.each do |recipient|
       #follow_email(recipient, post).deliver
       delay.follow_email(recipient, post)
     end
  end
  
  def follow_email(subscription, post)
    @subscription=subscription
    @post=post
    #mail to: 'silverskier@dimonix.com', subject: 'The post #{@post.title} has been commented'
    mail to: subscription, subject: 'A post has been commented'
  end

  def self.send_subscribe_email(subscriptions, post)
     #@subscriptions = subscriptions.collect(&:email).join(",")
     @subscriptions=subscriptions.pluck(:email)
     @subscriptions.each do |recipient|
       #subscribe_email(recipient, post).deliver
       delay.subscribe_email(recipient, post)
     end
  end
  
  def subscribe_email(subscription, post)
    @subscription=subscription
    @post=post
    #mail to: 'silverskier@dimonix.com', subject: 'The post #{@post.title} has been commented'
    mail to: subscription, subject: 'A post has been commented'
  end

=begin 
  def follow_email(subscriptions, post)
    @subscriptions=subscriptions
    @post=post
    #mail to: 'silverskier@dimonix.com', subject: 'The post #{@post.title} has been commented'
    mail to: Proc.new { subscriptions.pluck(:email) }, subject: 'The post #{@post.title} has been commented'
  end
=end

=begin
  def subscribe_email(subscriptions, post)
    @post=post
    @subscriptions=subscriptions
    mail to: 'silverskier@dimonix.com', subject: 'The post #{@post.title} has been created in Blog Sergi'
    #mail to: Proc.new { subscriptions.pluck(:email) }, subject: 'The post #{@post.title} has been created in Blog Sergi'
  end
=end
end
