class SiteController < ApplicationController
    layout 'site'

  def list_subjects
    @subjects = Subject.order(:description).all
  end
end
