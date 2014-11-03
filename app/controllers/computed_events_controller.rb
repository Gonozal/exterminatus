class ComputedEventsController < ApplicationController
  def index
    @last_events = ComputedEvent.prev(2)
    @next_events = ComputedEvent.next(5)
    Character.create_dummy_char_events
    @characters = Character.all.with_signups(@next_events + @last_events).load
  end
end
