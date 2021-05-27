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
  
  def send_for_everyone(member, mygroup) #打合せ項目 新着通知メール
    @url = "https://www.groups-app.net"
    @member = member
    @mygroup = mygroup
    mail(to: @member.email, subject: 'Groups|新着通知(打合せ項目)')
  end
  
  def new_notice_mail(member, mygroup) #お知らせ 新着通知メール
    @url = "https://www.groups-app.net"
    @member = member
    @mygroup = mygroup
    mail(to: @member.email, subject: 'Groups|新着通知(お知らせ)')
  end
  
  def new_account_mail(member, mygroup) #会計情報 新着通知メール
    @url = "https://www.groups-app.net"
    @member = member
    @mygroup = mygroup
    mail(to: @member.email, subject: 'Groups|新着通知(会計情報)')
  end
  
  def new_plan_mail(member, mygroup) #予定 新着通知メール
    @url = "https://www.groups-app.net"
    @member = member
    @mygroup = mygroup
    mail(to: @member.email, subject: 'Groups|新着通知(予定)')
  end
end
