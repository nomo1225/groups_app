class InquiryController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end
  
  def create #問い合わせ通知メール、完了メール送信
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      ContactMailer.inquiry_mail(@inquiry).deliver_now #自分への通知
      ContactMailer.inquiry_reply(@inquiry).deliver_now #ユーザへの完了通知
      flash[:success] = 'お問い合わせを送信しました。'
      redirect_to root_path
    else
      flash.now[:danger] = '送信できませんでした。'
      render :new
    end
  end
  
  private
  
  def inquiry_params
    params.permit(:name, :email, :message)
  end
end
