class AdminsBackoffice::AdminsController < AdminsBackofficeController
before_action :password_check, only: [:update]
before_action :set_admin, only: [:edit, :update, :destroy]


  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save # caso crie adm, voltar para a tabela de adm e exibir mensagem
      redirect_to admins_backoffice_admins_path, notice: "Adm criado com sucesso."
    else #caso não, voltar para a página de criação (pág. atual)
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.update(params_admin) # caso haja atualização, voltar para a tabela de adm e exibir mensagem
      AdminMailer.admin_update(current_admin, @admin).deliver_now
      redirect_to admins_backoffice_admins_path, notice: "Adm atualizado com sucesso."
    else #caso não consiga edição, voltar para a página edit (pág. atual)
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Adm excluído com sucesso."
    else #caso não consiga edição, voltar para a página edit (pág. atual)
      render :index
    end
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def params_admin
    params.require(:admin).permit(:email, :password, :password_confirmation) # limita os dados que serão enviados (segurança)
  end

  def password_check
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation) #remove a necessideade de senha caso ela não seja enviada
    end
  end

end