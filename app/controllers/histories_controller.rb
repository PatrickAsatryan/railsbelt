class HistoriesController < ApplicationController
  before_action :require_login
  def create
    giver = Lender.find(session[:user_id])
    receiver = Borrower.find(params[:borrower])

    if giver.money >= params[:amount].to_i && giver.money > 0
      history = History.create(:amount => params[:amount].to_i, :lender => giver, :borrower => receiver) unless History.where("lender_id = #{session[:user_id]} and borrower_id = #{params[:borrower]}").any?
      addhistory = History.find_by("lender_id = #{session[:user_id]} and borrower_id = #{params[:borrower]}").increment!(:amount, params[:amount].to_i) if History.where("lender_id = #{session[:user_id]} and borrower_id = #{params[:borrower]}").any?      
      gave = giver.decrement!(:money, params[:amount].to_i)
      received = receiver.increment!(:raised, params[:amount].to_i)
    else
      flash[:insufficient] = ["You do not have enough money!!!!!!!!!!!!"]
    end
     
    redirect_to :back
  end
end
