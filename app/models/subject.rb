class Subject < ApplicationRecord
  has_many :questions
  # set tag color helper
  def set_tag_color
    case self.id % 5
    when 1 then 'badge-warning'
    when 2 then 'badge-danger'
    when 3 then 'badge-info'
    when 4 then 'badge-success'
    else 'badge-primary'
    end
  end

  # Callback to count subjects
  after_create { AdminStatistic.set_event(AdminStatistic::EVENTS[:total_subjects]) }

  before_destroy { AdminStatistic.set_event(AdminStatistic::EVENTS[:total_subjects], false) }

end
