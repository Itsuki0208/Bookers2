class UsersController < ApplicationController

  def index
    @users = User.all
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.where(user_id: @user.id)
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
        flash[:notice]="You have updated user successfully."
        redirect_to user_path(current_user)
      else
        render :edit
      end
  end

private

def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
end

def correct_user
  @user = User.find(params[:id])
  redirect_to(user_params_path) unless @user == current_user
end

end