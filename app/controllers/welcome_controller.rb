class WelcomeController < ApplicationController
  def index
  end

  def ds_return
    @event = params[:event]
  end


end
