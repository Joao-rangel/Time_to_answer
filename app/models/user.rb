class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile  # connect tables
  accepts_nested_attributes_for :user_profile, reject_if: :all_blank # Active Record Nested Attributes

  # Callback
  after_create { AdminStatistic.set_event(AdminStatistic::EVENTS[:total_users]) }

  before_destroy { AdminStatistic.set_event(AdminStatistic::EVENTS[:total_users], false) }

end