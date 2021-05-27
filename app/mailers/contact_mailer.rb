class ContactMailer < ApplicationMailer
  # メール送信メソッド
  default from: ENV['GMAIL_EMAIL']
  
  def signup_mail(user) #登録完了通知
    @user = user
    @url = "https://www.groups-app.net"
    mail(to: @user.email, subject: 'Groupsへの登録完了通知')
  end
  
  def forget_pass(user) #パスワードリマインダー
    @user = user
    @url = "https://www.groups-app.net/reset_password?reset_token=#{@user.reset_token}"
    mail(to: @user.email, subject: 'Groupsのパスワード再設定メール')
  end
  
  def inquiry_mail(inquiry) #自分への問い合わせ通知メール
    @inquiry = inquiry
    mail(to: ENV['GMAIL_NOMO'], subject: 'Groupsへの問い合わせ')
  end
  
  def inquiry_reply(inquiry) #ユーザへの送信完了通知メール
    @inquiry = inquiry
    mail(to: @inquiry.email, subject: 'Groupsへのお問い合わせ')
  end
  
  def send_for_everyone(
    inquiry) #新規～通知メール
    mail(to: @inquiry.email, subject: 'Groupsへのお問い合わせ')
  end
end
