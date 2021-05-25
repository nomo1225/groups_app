class ApplicationMailer < ActionMailer::Base
  default from: ENV['GMAIL_EMAIL'] # デフォルトの送信メール
  layout 'mailer'
end