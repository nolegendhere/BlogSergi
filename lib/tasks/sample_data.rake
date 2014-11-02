namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "admin",
                         email: "admin@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true,
                         coadmin: true,
                         colaborator: true) 
    
  end
end
