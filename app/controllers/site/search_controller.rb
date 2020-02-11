class Site::SearchController < SiteController
  def questions
    # lower & downcase = para buscar no db sem ser case-sensitive. %TXT% busca o string dentro de qualquer intervalo.
    @questions = Question.like_search(params[:term], params[:page])
  end
end
