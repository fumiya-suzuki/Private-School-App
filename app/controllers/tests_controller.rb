class TestsController < ApplicationController
  before_action :set_user_id, only: [:new, :edit, :update, :create, :index, :destroy]
  before_action :set_user, only: :show_subject
  before_action :logged_in_user
  before_action :correct_user, only: [:new, :edit, :update, :create, :destroy]
  before_action :staff_or_correct_user, only: :index
  before_action :staff_invalid, only: [:new, :edit, :update, :create, :index, :destroy]
  before_action :set_test, only: [:edit, :update, :show_subject, :destroy]
  
  
  def new
    @test = Test.new
  end
  
  def edit 
  end
  
  def update
    if @test.update_attributes(test_params)
      flash[:success] = "テスト結果を編集しました。"
    else
      flash[:danger] = "テスト結果編集に失敗しました。"
    end
    redirect_to user_tests_path(@user)
  end
  
  def create
    @test = @user.tests.new(test_params)
    if @test.save
      flash[:success] = 'テスト結果を報告しました。'
    else
      render  :new
    end
    redirect_to user_tests_path(@user)
  end
  
  
  def index 
    @tests = Test.where(user_id: @user.id).order(day: "ASC")
    @demo_tests = Test.where(user_id: @user.id, types: 2).order(day: "ASC")
    @periodic_tests = Test.where(user_id: @user.id, types: 1).order(day: "ASC")
  end
  
  def show_subject
  end
  
  def destroy
    @test.destroy
    flash[:success] = "#{@test.name}のデータを削除しました。"
    redirect_to user_tests_url(@user)
  end
  
  
  private
  
  def test_params
    params.require(:test).permit(:day, :types, :english, :math, :japanese, :science, :society, :name, :five_subjects, :three_subjects)
  end
  
end
