class EventStatusesController < ApplicationController
  def index
    @last_events = ComputedEvent.prev(0)
    @next_events = ComputedEvent.next(5)
    @event_hash = EventStatus.status_hash(@last_events + @next_events)
  end
end
