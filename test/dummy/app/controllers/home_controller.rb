class HomeController < ApplicationController

  before_action :authenticate_user!
  before_action :initialize_binnacle_chat

  def home; end
end
