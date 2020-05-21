class Site::AnswerController < SiteController
  def question # .where aponta uma array de hashes, .find localiza um único elemento (hash)
    @answer = Answer.find(params[:answer_id])
    update_statistics(@answer)
  end

  private
  def update_statistics(answer)
    if user_signed_in?
      user_statistics = UserStatistic.find_or_create_by(user: current_user)
      answer.correct? ? user_statistics.right_questions += 1 : user_statistics.wrong_questions += 1
      user_statistics.save
    end
  end
end
