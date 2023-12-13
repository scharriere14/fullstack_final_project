namespace :db do
  desc "Drop, create, migrate, and seed the database"
  task reset: %i[drop create migrate seed] do
    puts "Database reset and seeded successfully."
  end
end
