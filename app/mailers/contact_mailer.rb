class ContactMailer < ApplicationMailer
  default from: ENV['GMAIL_EMAIL']
  
  def signup_mail(user)
    @user = user
    @url = "https://www.groups-app.net"
    mail(to: @user.email, subject: 'Groupsへの登録完了通知')
  end
  
  def forget_pass(user)
    @user = user
    @url = "https://groups_app.net/reset_password?reset_token=#{@user.reset_token}"
    mail(to: @user.email, subject: 'Groupsのパスワード再設定メール')
  end
end
