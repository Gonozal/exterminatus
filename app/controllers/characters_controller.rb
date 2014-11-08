class CharactersController < ApplicationController
  authorize_resource except: [:claim, :release]

  def index
    @characters = Character.eager_load(:team).order(:name)
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      redirect_to action: :index
    else
      @characters = Character.eager_load(:team).order(:name)
      render action: :index
    end
  end

  def claim
    @character = Character.find(params[:id])
    params[:user_id] = current_user.id
    if can? :claim, @character and @character.update_attributes claim_params
      current_user.update_attributes(last_claim: Time.now)
      flash[:notice] = "Succesfully claimed #{@character.name}."
    else
      flash[:warning] = "Could not claim #{@character.name}. Maybe someone was faster than you"
    end
    redirect_to action: :index
  end

  def release
    @character = Character.find(params[:id])
    params[:user_id] = nil
    if can? :release, @character and @character.update_attributes claim_params
      flash[:notice] = "Succesfully released #{@character.name}. Everyone can edit it now"
    else
      flash[:warning] = "Could not release #{@character.name}."
    end
    redirect_to action: :index
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to action: :index
  end

  def show
    events = ComputedEvent.prev(2) + ComputedEvent.next(4)
    @character_signups = Character.with_signups(events).find(params[:id])
    @character = Character.with_boss_preferences.find(params[:id])
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
  def claim_params
    params.permit(:user_id)
  end
end
