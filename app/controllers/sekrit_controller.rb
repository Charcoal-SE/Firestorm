class SekritController < ApplicationController
	before_filter :authenticate_user!
  def yay
  end
end
