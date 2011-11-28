class ContactsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @exchanged_count  = current_user.friends.registered.count
    @pending_count    = current_user.friends.unregistered.count
  end
end