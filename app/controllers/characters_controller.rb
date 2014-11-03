class CharactersController < ApplicationController
  def index
    @characters = Character.eager_load(:team).order(:name)
    @character = Character.new
  end

  def create
    @characters = Character.eager_load(:team).order(:name)
    @character = Character.new(character_params)
    if @character.save
      redirect_to action: :index
    else
      render action: :index
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to action: :index
  end

  def update
    @character = Character.find(params[:id])
    respond_to do |format|
      if @character.update_attributes(character_params)
        format.html
        format.json { head :no_content } # 204 No Content
      else
        format.html
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def character_params
    params.require(:character).permit(:name, :klass, :role, :team_id)
  end
end
