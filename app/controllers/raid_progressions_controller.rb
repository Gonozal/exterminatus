class RaidProgressionsController < ApplicationController
  def index
    BossPreference.create_dummy_preferences
    @bosses = RaidBoss.where(boss_type: 0)
    @characters = Character.with_boss_preferences.
                  where('raid_bosses.boss_type = ?', 0).order(:name)
  end

  def update
    @bp = BossPreference.find params[:id]
    respond_to do |format|
      if can? :edit, @bp and @bp.update_attributes(progression_params)
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
  def progression_params
    params.require(:boss_preference).permit(:progression)
  end
end
