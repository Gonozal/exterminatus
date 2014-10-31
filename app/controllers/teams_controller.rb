class TeamsController < ApplicationController
  def index
    @teams = Team.all
    @team = Team.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @teams = Team.all
    @team = Team.new(team_params)
    if @team.save
      redirect_to action: :index
    else
      render action: :index
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to action: :index
  end

  def update
    @team = Team.find(params[:id])
    @team.reload unless @team.update_attributes(team_params)
    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  private
  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def team_params
    params.require(:team).permit(:name, :shorthand)
  end
end
