class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  $days_of_the_week = %w{日 月 火 水 木 金 土}
  
  # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end
    
    def set_user_id
      @user = User.find(params[:user_id])
    end
    
    def set_test
      @test = Test.find(params[:id])
    end
    
    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    def logged_out_user
      if logged_in? 
        unless current_user.admin? || current_user.teacher? || current_user?(@user) || @user.teacher? || @user.admin?
          flash[:danger] = "アクセス権限がありません"
          redirect_to root_url
        end
      else
        unless @user.admin?
          store_location
          flash[:danger] = "ログインしてください"
          redirect_to login_url
        end
      end
    end
        
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      unless current_user?(@user) || current_user.admin?
        redirect_to(root_url) 
        flash[:danger] = "アクセス権限がありませeeeん。"
      end
    end
    
  
  # システム管理権限所有かどうか判定します。
  def admin_user
    unless current_user.admin?
      redirect_to root_url 
      flash[:danger] = "アクセス権限がありません。"
    end
  end
  
  # ログイン中のユーザーがスタッフユーザーかどうか
  def teacher_user
    unless current_user.teacher? || current_user.admin?
      redirect_to root_url 
      flash[:danger] = "アクセス権限がありません。"
    end
  end
  
  def teacher_user_page 
    unless @user.teacher?
     redirect_to(root_url)
     flash[:danger] = "アクセス出来ないページです。"
    end
  end
  
  # スタッフユーザーもしくはログイン中のユーザーか
  def staff_or_correct_user
      unless current_user?(@user) || current_user.admin? || current_user.teacher?
        redirect_to(root_url) 
        flash[:danger] = "アクセス権限がありません。"
      end
  end
  # スタッフユーザーには必要ないページ
  def staff_invalid
    if @user.teacher? || @user.admin?
      redirect_to(root_url) 
      flash[:danger] = "アクセス権限がありdddません。"
    end
  end
  
  def admin_user_page
    unless @user.admin?
     redirect_to(root_url)
     flash[:danger] = "アクセス出来ないページです。"
    end    
  end
  
  def set_one_month 
    @user = User.find(params[:user_id])
  @first_day = params[:date].nil? ?
  Date.current.beginning_of_month : params[:date].to_date
  @last_day = @first_day.end_of_month
  one_month = [*@first_day..@last_day] # 対象の月の日数を代入します。
  # ユーザーに紐付く一ヶ月分のレコードを検索し取得します。
  @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)

  unless one_month.count == @attendances.count # それぞれの件数（日数）が一致するか評価します。
    ActiveRecord::Base.transaction do # トランザクションを開始します。
      # 繰り返し処理により、1ヶ月分の勤怠データを生成します。
      one_month.each { |day| @user.attendances.create!(worked_on: day) }
    end
    @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
  end

  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
end
