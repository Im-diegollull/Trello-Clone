# class UsersController < ApplicationController
#     def index
#         @users = User.all
#     end

#     def show
# 		@user = User.find(params[:id])
# 	end

#     def new
# 		@user = User.new
# 	end

# 	def create  
# 		@user = User.new(user_params)
# 		if @user.save
# 			flash[:notice] = "User created successfully"
# 			redirect_to users_path
# 		else
# 			flash[:error] =  @user.errors.full_messages.to_sentence
# 			redirect_to new_user_path
# 		end
# 	end

#     def edit
# 		@user = User.find(params[:id])
# 	end

# 	def update
# 		@user = User.find(params[:id])
# 		if @user.update(user_params)
# 			flash[:notice] = "User updated successfully"
# 			redirect_to users_path
# 		else
# 			flash[:error] = @user.errors.full_messages.to_sentence
# 			redirect_to edit_user_path
# 		end
# 	end

#     def destroy
#         user = User.find_by(id: params[:id])
# 		Task.where(assignee_id: user.id).update_all(assignee_id: nil)
#         if user.destroy
# 			flash[:notice] = "user deleted successfully"
# 		else
# 			flash[:error] = user.errors.full_messages.to_sentence
# 		end
# 		redirect_to users_path
#     end


#     private

#     def user_params
# 		params.require(:user).permit(:name, :email, :password)
# 	end

# end 

class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
      @team_boards = @user.boards
      @created_boards = @user.created_boards
    end
end