class ContactsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @exchanged  = current_user.friends.registered
    @pending    = current_user.friends.unregistered

    respond_to do |format|
      format.html do
        @exchanged_count  = @exchanged.count
        @pending_count    = @pending.count
      end

      format.csv do
        render :layout => false
      end
    end
  end
end