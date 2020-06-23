class Site::SearchController < SiteController
  before_action :list_subjects

  def questions
    @questions = Question.like_search(params[:term], params[:page])
  end

  def subject
    @questions = Question.subject_set(params[:subject_id], params[:page])
  end
end
