class ReportsController < ApplicationController
  
  def show
    
  end
  
  def new
    @user = User.find(params[:user_id])
    @report = Report.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @report = @user.reports.new(report_params)
    if @report.save
      flash[:success] = '日報を塾長に提出しました。'
      redirect_to user_report_path(@user,@report)
    else
      render :new
    end
  end
  
  def index
    @user = User.find(params[:user_id])
    @reports = Report.where(user_id: @user.id)
  end
  
  private
  
    def report_params
      params.require(:report).permit(:day, :subject, :note, :teacher_id, :admin_confirm)
    end
end
