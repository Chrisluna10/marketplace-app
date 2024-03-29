class RegistrationsController < Devise::RegistrationsController

    def create
      @user = User.new(user_params)
      if @user.save
          sign_in :user, @user
          render json: {
              user: @user,
              status: "created"
          } 
        elsif User.exists?(username: @user.username)
        render json:{
          status: "username_exists"
        }
      elsif
        warden.custom_failure!
        render json: { error: 'signup error' , status: @user.errors }
      end
    end
  
    def update
      @user = current_user
      if @user.update(user_params)
        render json: {
          user: @user,
          status: "edit successful"
        }
      else
        warden.custom_failure!
        render :json=> @user.errors, :status=>422
      end
   end
  
    def destroy
      @user = User.find_by_email(user_params[:email])
      if @user.destroy
        render :json=> { success: 'user was successfully deleted' }, :status=>201
      else
        render :json=> { error: 'user could not be deleted' }, :status=>422
      end
    end
  
    private
  
    def user_params
       params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  end