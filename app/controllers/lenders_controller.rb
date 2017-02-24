class LendersController < ApplicationController
  before_action :require_login, only: [:show]

  def create
    lender = Lender.new(lender_params)

    if lender.valid?
      lender.save
      session[:user_id] = lender.id
      redirect_to "/lenders/#{session[:user_id]}"
    else
      flash[:lender] = lender.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @user = Lender.find(session[:user_id])
    @borrowers = Borrower.all
  end

  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
  end
end
