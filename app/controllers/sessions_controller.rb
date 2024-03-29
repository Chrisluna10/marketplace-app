class SessionsController < Devise::SessionsController

    # POST /v1/login
    def create
      @user = User.find_by_username(user_params[:username])
      return invalid_login_attempt unless @user
  
      if @user.valid_password?(user_params[:password])
        sign_in :user, @user
        render json: {
            user: @user,
            status: "logged_in"
        }
      else
        invalid_login_attempt
      end
    end
  
    def destroy
      sign_out(@user)
      render :json=> {
          status: "signed_out"
      }
    end
  
  
      private
  
      def invalid_login_attempt
        warden.custom_failure!
        render json: {error: 'invalid login attempt'}, status: :unprocessable_entity
      end
  
      def user_params
         params.require(:user).permit(:username, :password)
      end
  
  end