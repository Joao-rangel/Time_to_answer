class UserProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  
  # Virtual Attributes
  def full_name
    [self.first_name, self.last_name].join(' ')
  end

end
