class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions, counter_cache: true
  has_many :answers # connect tables
  # Active Record Nested Attributes
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  # Callback
  after_create :set_statistic

  scope :like_search, -> (term, page) {
    where("lower(description) LIKE ?", "%#{term.downcase}%")
    .includes(:answers, :subject).page(page).per(10)
  }

  scope :subject_set, -> (subject_id, page) {
    where(subject_id: subject_id) # quando vai buscar diretamente com = pode escrever assim
    .includes(:answers, :subject).page(page).per(10)
  }

  scope :order_desc, -> (page) {
    order('created_at desc').includes(:answers, :subject)
    .page(page).per(10)
  }

  def set_tag_color
    case self.subject.description
    when 'Kids' then 'badge-danger'
    when 'Teens' then 'badge-info'
    when 'Standard' then 'badge-success'
    when 'Play & Fun' then 'badge-warning'
    else 'badge-primary'
    end
  end

  private
  
  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_questions])
  end
end
