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
  
  def follow_email(subscriptions, post)
    @subscriptions=subscriptions
    mail to: 'silverskier@dimonix.com', subject: 'The post #{post.title} has been commented'
    #mail to: Proc.new { subscriptions.pluck(:email) }, subject: 'The post #{post.title} has been commented'
  end
end
