module UsersBackofficeHelper

  private
 
  def set_avatar
    unless current_user.user_profile
      'img.jpg'
    else
      avatar = current_user.user_profile.avatar
      avatar.attached? ? avatar : 'img.jpg'
    end
  end
end
