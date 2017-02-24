class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    redirect_to '/sessions/new' if session[:user_id] == nil
  end

  def be_a_lender
    redirect_to "/borrowers/#{session[:user_id]}" unless session[:lender] == true and params[:id] == session[:user_id]
  end

  def be_a_borrower
    redirect_to "/lenders/#{session[:user_id]}" unless session[:borrower] == true and params[:id] == session[:user_id]
  end
end
