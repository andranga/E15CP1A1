class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
	    @user = User.find_by(email: params[:user][:email])
		if @user.nil?
			@user = User.new(user_params)
		    if @user.save
		    	session[:user_id] = @user.id
		    	redirect_to root_path
		    else
		    	redirect_to root_path, alert: 'Usuario no pudo ser creado'
		    end
		else
			redirect_to root_path, alert: 'Usuario ya existe'
		end
    end

	private
	def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
