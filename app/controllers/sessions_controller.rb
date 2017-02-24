class SessionsController < ApplicationController
  def register
  end

  def new
  end

  def create
    borrower = Borrower.find_by(email: params[:email])
    lender = Lender.find_by(email: params[:email])

    if borrower && borrower.authenticate(params[:password])
      session[:user_id] = borrower.id
      session[:borrower] = true
      redirect_to "/borrowers/#{session[:user_id]}"
    elsif lender && lender.authenticate(params[:password])
      session[:user_id] = lender.id
      session[:lender] = true
      redirect_to "/lenders/#{session[:user_id]}"
    else
      flash[:log] = ["Incorrect email or password"]
      redirect_to :back
    end
  end

  def destroy
    reset_session
    redirect_to "/sessions/new"
  end
end
