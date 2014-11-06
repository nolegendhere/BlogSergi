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
end
