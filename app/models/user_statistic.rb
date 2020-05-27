class UserStatistic < ApplicationRecord
  belongs_to :user

  def total_questions
      self.right_questions + self.wrong_questions
  end

  def right_ratio
    self.total_questions == 0 ? 100 : (100 * self.right_questions / self.total_questions).round
  end

  def wrong_ratio
    100 - self.right_ratio
  end

  def self.update_answers(answer, current_user)
    if !!current_user # !! negates 2 times (used to remove nil and gives false instead)
      user_statistic = UserStatistic.find_or_create_by(user: current_user)
      answer.correct? ? user_statistic.right_questions += 1 : user_statistic.wrong_questions += 1
      user_statistic.save
    end
  end
end
