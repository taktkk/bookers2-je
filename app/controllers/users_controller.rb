class UsersController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  before_action :set_q, only: [:index, :search]

  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
        render "edit"
    else
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:alert] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render 'users/edit'
    end  
  end

  def search
    @results = @q.result
  end
  
  
  private

  def set_q
    @q = User.ransack(params[:q])
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :postal_code, :prefecture_code, :city, :street)
  end
  
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to "/users/#{current_user.id}"
    end
  end
end