class AttendancesController < ApplicationController
  before_action :set_user_id, only: [:index, :update_one_month]
  before_action :logged_in_user
  before_action :correct_user
  before_action :set_one_month, only: :index
  before_action :teacher_user_page  
  def index
    @attendances_break = @user.attendances.where(c_one: nil, c_two: nil, k_one: nil, k_two: nil, worked_on: @first_day..@last_day).order(:worked_on).count
  end
  
  def update_one_month
  ActiveRecord::Base.transaction do # トランザクションを開始します。
    attendances_params.each do |id, item|
      attendance = Attendance.find(id)
      attendance.update_attributes!(item)
    end
  end
    flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
    redirect_to user_attendances_url(date: params[:date])
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to user_attendances_url(date: params[:date])
  end
  
  private
  
    def attendances_params
      params.require(:user).permit(attendances: [:c_one, :c_two, :k_one, :k_two])[:attendances]
    end
  
end
