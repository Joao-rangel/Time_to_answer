module SiteHelper
  def set_site_message
    case params[:action]
    when 'index'
      'Ultimas perguntas cadastradas.'
    when 'questions'
      "Resultados para a busca: \"#{params[:term]}\""
    when 'subject'
      "Exibindo categoria: #{params[:subject_description]}"
    end
  end
end
