class TestsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @test = Test.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @test = @user.tests.new(test_params)
    if @test.save
      flash[:success] = 'テスト結果を報告しました。'
    else
      render  :new
    end
    redirect_to user_tests_path(@user)
  end
  
  
  def index 
    @user = User.find(params[:user_id])
    @tests = Test.where(user_id: @user.id)
    @demo_tests = Test.where(user_id: @user.id, types: 2)
    @periodic_tests = Test.where(user_id: @user.id, types: 1)
  end
  
  def show_subject
    @user = User.find(params[:id])
    @test = Test.find(params[:id])
  end
  
  
  private
  
  def test_params
    params.require(:test).permit(:day, :types, :english, :math, :japanese, :science, :society, :name, :five_subjects, :three_subjects)
  end
  
end
