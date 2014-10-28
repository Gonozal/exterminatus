class CharactersController < ApplicationController
  def index
    @characters = Character.all
    @character = Character.new
  end

  def create
    @characters = Character.all
    @character = Character.new(character_params)
    if @character.save
      render action: :index
    else
      render action: :index
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to characters_path
  end

  def update
    @character = Character.find(params[:id])
    @character.reload unless @character.update_attributes(character_params)
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def character_params
    if params[:character].has_key? :team_shorthand
      team = Team.where(shorthand: params[:character].delete(:team_shorthand))
      params[:character][:team_id] = team.blank?? nil : team.first.id
    end
    params.require(:character).permit(:name, :klass, :role, :team_id)
  end
end
