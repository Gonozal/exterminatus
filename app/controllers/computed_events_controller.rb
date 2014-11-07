class ComputedEventsController < ApplicationController
  authorize_resource
  def index
    @last_events = ComputedEvent.prev(1)
    @next_events = ComputedEvent.next(5)
    CharacterEvent.create_dummy_char_events(@last_events + @next_events)
    @characters = Character.all.with_signups(@next_events + @last_events)
  end
end
