class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers
  # Active Record Nested Attributes
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  scope :like_search, -> (term, page) {
    where("lower(description) LIKE ?", "%#{term.downcase}%")
    .includes(:answers, :subject).page(page).per(10)
  }

  scope :order_desc, -> (page) {
    order('created_at desc').includes(:answers, :subject)
    .page(page).per(10)
  }

end
