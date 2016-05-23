class FlagsController < ApplicationController
	before_action :authenticate_user!, except: [:view, :add_data]
  before_action :set_flag, :except => [:index, :new, :create, :view]

	def index
    @flags = current_user.flags
	end

	def show
		if @flag.user != current_user
			not_found
		end
    @share_link = PresignedLink.find_by_flag_id(@flag.id)
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
		FlagDatum.where(:flag_id => params[:id]).each do |d|
			d.destroy
		end
		redirect_to "/flags"
	end

	def view
		link = PresignedLink.find_by_presigned_string(params[:presigned_string])
		if link.nil? || link.flag_id != params[:id].to_i
			not_found
			return
		end

		@flag = Flag.find(params[:id])
	end

	def add_data
		data = FlagDatum.new(flag_datum_params)
		data.flag = @flag
		data.save!
		render text: "success"
	end

  def add_note
    note = FlagComment.new(flag_comment_params)
    note.flag = @flag
    note.save!
    redirect_to flag_path(@flag.id)
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
      @flag = Flag.find params[:id]
    end

    def flag_params
      params.require(:flag).permit(:title, :summary)
    end

    def flag_comment_params
      params.require(:flag_comment).permit(:username, :body)
    end

    def flag_datum_params
      params.require(:flag_datum).permit(:key, :value)
    end
end
