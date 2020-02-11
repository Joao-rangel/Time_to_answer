class Site::WelcomeController < SiteController
  def index
    @questions = Question.order_desc(params[:page])
  end
end
