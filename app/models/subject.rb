class Subject < ApplicationRecord
  has_many :questions

  # set tag color helper
  def set_tag_color
    case self.description
    when 'Kids' then 'badge-danger'
    when 'Teens' then 'badge-info'
    when 'Standard' then 'badge-success'
    when 'Play & Fun' then 'badge-warning'
    else 'badge-primary'
    end
  end

  # Callback to count subjects
  after_create { AdminStatistic.set_event(AdminStatistic::EVENTS[:total_subjects]) }

  before_destroy { AdminStatistic.set_event(AdminStatistic::EVENTS[:total_subjects], false) }

end
