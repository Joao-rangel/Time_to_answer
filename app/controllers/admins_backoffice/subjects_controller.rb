class AdminsBackoffice::SubjectsController < AdminsBackofficeController
before_action :set_subject, only: [:edit, :update, :destroy]    

  def index
    @subjects = Subject.order(:description).all
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(params_subject)
    if @subject.save # caso crie subject, voltar para a tabela de sbj e exibir mensagem
      redirect_to admins_backoffice_subjects_path, notice: "Tópico criado com sucesso."
    else #caso não, voltar para a página de criação (pág. atual)
      render :new
    end
  end

  def edit
  end

  def update
    if @subject.update(params_subject) # caso haja atualização, voltar para a tabela de adm e exibir mensagem
      redirect_to admins_backoffice_subjects_path, notice: "Tópico atualizado com sucesso."
    else #caso não consiga edição, voltar para a página edit (pág. atual)
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Tópico excluído com sucesso."
    else #caso não consiga edição, voltar para a página edit (pág. atual)
      render :index
    end
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def params_subject
    params.require(:subject).permit(:description) # limita os dados que serão enviados (segurança)
  end
end