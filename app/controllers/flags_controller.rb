class FlagsController < ApplicationController
	before_filter :authenticate_user!, except: [:view, :add_data]
  before_action :set_flag, :except => [:new, :create, :view]

	def index
	end

	def show
		if @flag.creator != current_user.id
			not_found
		end
	end

	def new
		@flag = Flag.new
	end

	def create
		flag = Flag.new
		flag.title = params[:flag]["title"]
		flag.summary = params[:flag]["summary"]
		flag.creator = current_user
		flag.save!
		link = PresignedLinks.new
		link.flag_id = flag.id
		link.presigned_string = SecureRandom.urlsafe_base64(5)
		link.save!
		redirect_to flag_path(:id => flag.id)
	end

	def destroy
		@flag.delete()
		FlagData.find_all_by_flag_id(params[:id]).each do |d|
			d.delete()
		end
		redirect_to "/flags"
	end

	def view
		puts "logfind2: #{params}"

		link=PresignedLinks.find_by_presigned_string(params["presigned_string"])
		if !link or link.flag_id != params["id"].to_i
			not_found
			return
		end

		@flag = Flag.find_by_id(params["id"])
	end

	def add_data
		data = FlagData.new
		data.flag_id = @flag.id
		data.key = params[:key]
		data.object = params[:value]
		data.save!
		render text: "success"
	end

	def edit
	end

	def update
		@flag.summary = params["flag"]["summary"]
		@flag.title = params["flag"]["title"]
		@flag.save!
		redirect_to flag_path(@flag.id)
	end

  private
    def set_flag
      @flag = Flag.find params[:flag_id]
    end
end
