class UserStatistic < ApplicationRecord
  belongs_to :user

  def total_questions
      self.right_questions + self.wrong_questions
  end

  def right_ratio
    (100 * self.right_questions / self.total_questions).round
  end

  def wrong_ratio
    100 - self.right_ratio
  end
end
