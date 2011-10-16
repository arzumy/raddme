require 'spec_helper'

describe HomeController do
  describe "GET about" do
    it "displays about us page" do
      get :about
      response.should render_template(:about)
    end
  end
end