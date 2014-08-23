class FlagsController < ApplicationController
	before_filter :authenticate_user!, except: [:view, :add_data]
	def index

	end
	def show
		@flag = Flag.find_by_id(params[:id]) || not_found
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
		Flag.find_by_id(params["id"]).delete()
		FlagData.find_all_by_flag_id(params["id"]).each do |d|
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
		flag = Flag.find_by_id(params["flag_id"])
		if !flag
			render text: "flag doesn't exist"
			return
		end
		data = FlagData.new
		data.flag_id = flag.id
		data.key = params["key"]
		data.object = params["value"]
		data.save!
		render text: "success"
	end
	def edit
		puts "logfind3: #{params}"
		@flag = Flag.find_by_id(params["id"].to_i)
	end
	def update
		flag = Flag.find_by_id(params["id"])
		flag.summary = params["flag"]["summary"]
		flag.title = params["flag"]["title"]
		flag.save!
		redirect_to flag_path(params["id"])
	end
end	
