class Site::WelcomeController < SiteController
  before_action :list_subjects
  
  def index
    @questions = Question.order_desc(params[:page])
  end
end
