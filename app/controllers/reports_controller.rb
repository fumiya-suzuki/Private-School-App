class ReportsController < ApplicationController
  before_action :set_user_id, only: [:new, :create, :index, :admin_update]
  before_action :set_user, only: :admin_index
  before_action :logged_in_user
  before_action :admin_user, only: [:admin_index, :admin_update]
  before_action :admin_user_page, only: [:admin_index, :admin_update]
  before_action :teacher_user, only: [:index, :new, :create, :show]
  before_action :staff_invalid, only: [:show, :new, :create, :index,]

  
  
  def show
    
  end
  
  def new
    @report = Report.new
  end
  
  def create
    @report = @user.reports.new(report_params)
    if @report.save
      flash[:success] = '日報を塾長に提出しました。'
      redirect_to user_reports_path(@user,@report)
    else
      render :new
    end
  end
  
  def index
    @reports = Report.where(user_id: @user.id)
  end
  
  def admin_index
    @reports = Report.where(admin_confirm: 1)
  end
  
  def admin_update
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
