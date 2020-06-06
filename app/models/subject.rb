class Subject < ApplicationRecord
  has_many :questions

  # Callback
  after_create { AdminStatistic.set_event(AdminStatistic::EVENTS[:total_subjects]) }

  before_destroy { AdminStatistic.set_event(AdminStatistic::EVENTS[:total_subjects], false) }

end
