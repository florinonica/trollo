class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :destroy, :remove_role, :files]

  def index
    @users = User.paginate(:page => params[:page], per_page:5)
  end

  def show
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    if @user.save
      if params[:type] == "Employee"
        save_roles
      end
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      save_roles
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def remove_role
    @role = Role.find(params[:role_id])
    @user.roles = @user.roles - [@role]
    redirect_to user_path(@user)
  end

  def files
  end

  def unread
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :role_ids, :last_name, :username, :nickname, :position, :email, :password, :password_confirmation, :type, :avatar)
    end

    def get_user
      @user = User.find(params[:id])
    end

    def save_roles
      params.require(:user).permit(:role_ids => [])

      unless params[:user][:role_ids].nil?
        params[:user][:role_ids].each do |rol|
          @user.roles << Role.find(rol)
        end
      end
    end
end
