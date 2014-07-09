class FlagsController < ApplicationController
	before_filter :authenticate_user!, :except => :show
	def index

	end
	def show
		@flag = Flag.find_by_id(params[:id]) || not_found
	end
	def new
		@flag = Flag.new
	end
	def create
		puts "logfind: #{params[:flag]}"
		flag = Flag.new
		flag.title = params[:flag]["title"]
		flag.save!
	end
end
