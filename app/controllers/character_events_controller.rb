# coding: iso-8859-1
class CharacterEventsController < ApplicationController
  def index
    @last_events = ComputedEvent.prev(2)
    @next_events = ComputedEvent.next(5)
    @character_events = CharacterEvent.where_signups(@next_events + @last_events).load
  end

  def update
    @ce = CharacterEvent.find_or_initialize_by(
      character_id: params[:c_id], computed_event_id: params[:e_id]
    )
    @ce.update_attributes(character_event_params)
    respond_to do |format|
      format.json
    end
  end

  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def character_event_params
    status = params[:character_event][:status]
    if status.kind_of? String
      int_status = 0
      EVENT_STATUS.size.times do |i|
        int_status = i if /^#{status.downcase}.*/ =~ EVENT_STATUS[i].downcase
      end
      params[:character_event][:status] = int_status
    end
    params.require(:character_event).permit(:status)
  end
end
