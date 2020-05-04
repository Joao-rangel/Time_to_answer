module UsersBackofficeHelper

  private
  
  def set_avatar
    avatar = current_user.user_profile.avatar
    avatar.attached? ? avatar : 'img.jpg'
  end
end
