class FlagsController < ApplicationController
	before_action :authenticate_user!, except: [:view, :add_data]
  before_action :set_flag, :except => [:new, :create, :view]

	def index
	end

	def show
		if @flag.user != current_user.id
			not_found
		end
	end

	def new
		@flag = Flag.new
	end

	def create
		flag = Flag.new(flag_params)
		flag.user = current_user
		flag.save!

		link = PresignedLink.new
		link.flag_id = flag.id
		link.presigned_string = SecureRandom.urlsafe_base64(5)
		link.save!

		redirect_to flag_path(:id => flag.id)
	end

	def destroy
		@flag.destroy
		FlagData.find_all_by_flag_id(params[:id]).each do |d|
			d.delete()
		end
		redirect_to "/flags"
	end

	def view
		link = PresignedLink.find_by_presigned_string(params[:presigned_string])
		if !link or link.flag_id != params[:id]
			not_found
			return
		end

		@flag = Flag.find(params[:id])
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
		@flag.update(flag_params)
		@flag.save!
		redirect_to flag_path(@flag.id)
	end

  private
    def set_flag
      @flag = Flag.find params[:flag_id]
    end

    def flag_params
      params.require(:flag).permit(:title, :summary)
    end
end
