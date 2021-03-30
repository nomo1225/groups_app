class InquiryController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end
  
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      ContactMailer.inquiry_mail(@inquiry).deliver_now
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
