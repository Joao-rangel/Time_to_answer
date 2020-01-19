class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    @admins = Admin.all
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    admin = Admin.find(params[:id])
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation) # limita os dados que serão enviados (segurança)
  
    if admin.update(params_admin) # caso haja atualização, voltar para a tabela de adm e exibir mensagem
      redirect_to admins_backoffice_admins_path, notice: "Adm atualizado com sucesso."
    else #caso não consiga edição, voltar para a página edit (pág. atual)
      render :edit
    end
  end
end
