class UsersController < ApplicationController
  before_action :is_admin?
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
  	@users = User.all
  end
  
  def show
  end  
  
  def edit
  end
  
  def update
  	if user_params[:password] == ""
  		assing_params = user_params.dup.except(:password, :password_confirmation)
  	else
  		assing_params = user_params.dup
  	end
    respond_to do |format|
      if @user.update(assing_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to edit_user_path, notice: 'User was not able to update' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'History was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
	def set_user
	  @user = User.find(params[:id])
	end
	# Never trust parameters from the scary internet, only allow the white list through.
	def user_params
	  params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :current_password, :admin)
	end
	def is_admin?
	  redirect_to histories_url, notice: 'You cant access this operation' if !current_user.admin?
	end
end
