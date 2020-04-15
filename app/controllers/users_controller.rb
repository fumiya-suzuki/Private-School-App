class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end
  
  def index
    
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :tel, :number, :school, :grade, :number, :password, :password_confirmation)
    end
end
