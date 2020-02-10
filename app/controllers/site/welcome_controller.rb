class Site::WelcomeController < SiteController
  def index
    @questions = Question.includes(:answers, :subject).page(params[:page]).per(10)
  end
end
