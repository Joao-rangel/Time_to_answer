class Site::AnswerController < SiteController
  def question # .where aponta uma array de hashes, .find localiza um único elemento (hash)
    @answer = Answer.find(params[:answer_id])
    UserStatistic.update_answers(@answer, current_user)
  end

end
