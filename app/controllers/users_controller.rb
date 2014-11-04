class UsersController < ApplicationController
  authorize_resource

  def index
    @users = User.all.eager_load(:characters).order(:name)
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html
        format.json { head :no_content } # 204 No Content
      else
        format.html
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def user_params
    params.require(:user).permit(:rank)
  end
end
