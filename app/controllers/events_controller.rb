class EventsController < ApplicationController
  def index
    @events = Event.all
    @event = Event.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @events = Event.all
    @event = Event.new(event_params)
    if @event.save
      redirect_to action: :index
    else
      render action: :index
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to action: :index
  end

  def update
    @event = Event.find(params[:id])
    @event.reload unless @event.update_attributes(event_params)
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def event_params
    params.require(:event).permit(:name, :event_type, :date, :start_date, :end_date)
  end
end
