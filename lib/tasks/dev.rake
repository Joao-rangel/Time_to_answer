# para usar esta rake: 'rails dev:setup'

namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root,'lib','tmp')

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop:_unsafe) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
      show_spinner("Cadastrando administrador padrão...") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando administradores extras...") { %x(rails dev:add_extra_admin) }
      show_spinner("Cadastrando usuário padrão...") { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando assuntos padrões...") { %x(rails dev:add_default_subjects) }
      show_spinner("Cadastrando questões...") { %x(rails dev:add_questions) }
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Popula com administradores extras"
  task add_extra_admin: :environment do
    5.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona assuntos padrões"
  task add_default_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each {|line| Subject.create!(description: line.strip)}
  end

  desc "Adiciona perguntas e respostas"
  task add_questions: :environment do
    Subject.all.each do |subject|
      rand(3..6).times do |i|
        # Array criado para criar cada questão
        params = { question: {
          description: "#{Faker::Lorem.question}",
          subject: subject,
          answers_attributes: []
        } }
        
        # Array com as hashs p/ answers
        answers_array = params[:question][:answers_attributes] 

        # Cria cada resposta c/ padrão "incorreto"
        rand(2..5).times do |j|
          answers_array.push(
            description: "#{Faker::Lorem.sentence}",
            correct: false
          )
        end

        # seleciona uma resposta como "correta"
        answers_array[rand(answers_array.count)][:correct] = true

        # salva a questão no db
        Question.create!(params[:question])
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")    
  end
end