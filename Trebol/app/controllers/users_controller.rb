class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
		@user = User.find(params[:id])
	end

    def new
		@user = User.new
	end

	def create  
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "User created successfully"
			redirect_to users_path
		else
			flash[:error] =  @user.errors.full_messages.to_sentence
			redirect_to new_user_path
		end
	end


    private

    def user_params
		params.require(:user).permit(:name, :email, :password)
	end

end 