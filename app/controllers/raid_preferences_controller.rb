class RaidPreferencesController < ApplicationController
  def update
    @bp = BossPreference.find params[:id]
    respond_to do |format|
      if can? :edit, @bp and @bp.update_attributes(preference_params)
        format.html
        format.json
      else
        format.html
        format.json { render json: @bp.errors, status: :unprocessable_entity }
      end
      format.json
    end
  end

  private
  def preference_params
    params.require(:boss_preference).permit(:preference)
  end
end
