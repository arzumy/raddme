class OfflineController < ApplicationController
  def show
    headers['Content-Type'] = 'text/cache-manifest'
    render template: "offline/show", layout: false
  end
end