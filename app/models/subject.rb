class Subject < ApplicationRecord
  has_many :questions

  # Callback
  after_create do
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_subjects])
  end

  before_destroy do
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_subjects], false)
  end

end
