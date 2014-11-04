class CharacterEventsController < ApplicationController
  authorize_resource
  def index
    @last_events = ComputedEvent.prev(2)
    @next_events = ComputedEvent.next(5)
    @character_events = CharacterEvent.where_signups(@next_events + @last_events).load
  end

  def update
    @ce = CharacterEvent.find_or_initialize_by(
      character_id: params[:c_id], computed_event_id: params[:e_id]
    )
    respond_to do |format|
      if can? :edit, @ce and @ce.update_attributes(character_event_params)
        format.html
        format.json
      else
        format.html
        format.json { render json: @ce.errors, status: :unprocessable_entity }
      end
      format.json
    end
  end

  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def character_event_params
    params.require(:character_event).permit(:status)
  end
end
