namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Sergi",
                         email: "sergigarciapena@gmail.com",
                         password: "hunter",
                         password_confirmation: "hunter",
                         admin: true,
                         coadmin: true,
                         colaborator: true) 
    
  end
end
