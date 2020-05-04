class UsersBackoffice::ProfileController < UsersBackofficeController
  before_action :password_check, only: [:update]
  before_action :set_user

  def edit
    @user.build_user_profile if @user.user_profile.blank? # para criar o perfil caso ainda não exista
  end

  def update
    if @user.update(params_user)
      bypass_sign_in(@user)
      redirect_to users_backoffice_profile_path, notice: "Atualizado com sucesso." unless params_user[:user_profile_attributes][:avatar]
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def params_user
    params.require(:user).permit(:email, :password, :password_confirmation, 
    user_profile_attributes: [:id, :first_name, :last_name, :gender, :birthdate, :city, :state, :avatar])
  end
  
  def password_check
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end
end
