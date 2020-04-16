class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(number: params[:session][:number])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end
  
  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
