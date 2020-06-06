class UserProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  
  # Validations
  validates :first_name, :last_name, presence: true, length: { minimum: 3 }

  # Virtual Attributes
  def full_name
    [self.first_name, self.last_name].join(' ')
  end

end
