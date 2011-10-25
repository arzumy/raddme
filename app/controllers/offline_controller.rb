class OfflineController < ApplicationController
  def show
    render template: "offline/show", layout: false, content_type: 'text/cache-manifest'
  end
end