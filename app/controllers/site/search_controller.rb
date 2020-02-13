class Site::SearchController < SiteController
  def questions
    # lower & downcase = para buscar no db sem ser case-sensitive. %TXT% busca o string dentro de qualquer intervalo.
    @questions = Question.like_search(params[:term], params[:page])
  end

  def subject
    @questions = Question.subject_set(params[:subject_id], params[:page])
  end
end
