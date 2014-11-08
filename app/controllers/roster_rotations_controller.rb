class RosterRotationsController < ApplicationController
  def index
    events = ComputedEvent.next(5)
    @events = ComputedEvent.roster_for_events(events)

  end
end
