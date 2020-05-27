class AdminStatistic < ApplicationRecord
  EVENTS = {
    total_users: "TOTAL_USERS",
    total_subjects: "TOTAL_SUBJECTS",
    total_questions: "TOTAL_QUESTIONS"
  }

  def self.set_event(event)
    admin_statistic = AdminStatistic.find_or_create_by(event: event)
    admin_statistic.value = 0 if not admin_statistic.value
    admin_statistic.value += 1
    admin_statistic.save
  end
end
