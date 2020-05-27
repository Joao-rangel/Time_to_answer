class Subject < ApplicationRecord
  has_many :questions

  # Callback
  after_create :set_statistic

  private
  
  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_subjects])
  end
end
