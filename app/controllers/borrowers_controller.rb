class BorrowersController < ApplicationController
  before_action :require_login, only: [:show]

  def create
    borrower = Borrower.new(borrower_params)

    if borrower.valid?
      borrower.save
      session[:user_id] = borrower.id
      redirect_to "/borrowers/#{session[:user_id]}"
    else
      flash[:borrower] = borrower.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @user = Borrower.find(session[:user_id])
    @lenders = Borrower.all.joins("JOIN histories ON histories.borrower_id = borrowers.id").joins("JOIN lenders ON histories.lender_id = lenders.id").where("borrowers.id = #{@user.id}").select("lenders.first_name", "lenders.last_name", "lenders.email", "histories.amount")
  end

  private
  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :purpose, :description, :money, :raised)
  end
end
