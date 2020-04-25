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
      redirect_to user_reports_path(@user,@report)
    else
      render :new
    end
  end
  
  def index
    @user = User.find(params[:user_id])
    @reports = Report.where(user_id: @user.id)
  end
  
  def admin_index
    @user = User.find(params[:id])
    @reports = Report.where(admin_confirm: 1)
  end
  
  def admin_update
    @user = User.find(params[:user_id])
    reports_params.each do |id, item|
      @report = Report.find(id)
       if params[:user][:reports][id][:change] == "1"
        if @report.update_attributes!(item)
          flash[:success] = "日報チェックしました"
        else
          flash[:danger] = "日報チェックできませんでした"
        end
       end
    end
    redirect_to reports_admin_index_user_path(@user)
  end
  
  private
  
    def report_params
      params.require(:report).permit(:day, :subject, :note, :teacher_id, :admin_confirm)
    end
    
    def reports_params
       params.require(:user).permit(reports: [:admin_confirm])[:reports]
    end
end
