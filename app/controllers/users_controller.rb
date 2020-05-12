class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_teacher, :update_teacher]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :index_teacher, :edit_teacher, :update_teacher, :search]
  before_action :correct_user, only: [:edit, :update, :destroy, :edit_teacher, :update_teacher]
  before_action :logged_out_user, only: :show
  
  
  def new
    @user = User.new
  end
  
  def show
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user unless current_user.admin?
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end
  
  
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end
  
  def index
    @users = User.paginate(page: params[:page]).where(teacher: false).where.not(admin: true)
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def index_teacher
    @users = User.paginate(page: params[:page]).where(teacher: true)
  end
  
  def new_teacher
    @user = User.new
  end
  
  def create_teacher
    @user = User.new(teacher_params)
    if @user.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user
    else
      render :new_teacher
    end
  end
  
  def edit_teacher
    
  end
  
  def update_teacher
    if @user.update_attributes(teacher_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def search
    @users = User.where('grade LIKE ?', "%#{params[:grade]}%").where.not(admin: true)
    @users = @users.paginate(page: params[:page])
    render :index
  end

  
  private

    def user_params
      params.require(:user).permit(:name, :tel, :number, :school, :grade, :password, :password_confirmation)
    end
    
    def teacher_params
      params.require(:user).permit(:name, :tel, :number, :school, :grade, :password, :password_confirmation, :teacher, :image)
    end
    
    
end
