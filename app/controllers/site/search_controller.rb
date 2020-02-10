class Site::SearchController < SiteController
  def questions
    # lower & downcase = para buscar no db sem ser case-sensitive. %TXT% busca o string dentro de qualquer intervalo.
    @questions = Question.where("lower(description) LIKE ?", "%#{params[:term].downcase}%")
                         .includes(:answers, :subject).page(params[:page]).per(10)
  end
end
