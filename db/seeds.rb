unless Rails.env.production?
  Planet.destroy_all
  Person.destroy_all
  Film.destroy_all
  User.destroy_all

  connection = ActiveRecord::Base.connection

  sql = File.read("db/populate.sql")
  statements = sql.split(/;$/)
  statements.pop

  begin
    ActiveRecord::Base.transaction do
      statements.each { |statement| connection.execute(statement) }
    end
    User.create!(
      [
        {
          name: "Root",
          username: "root",
          password: "admin123",
          email: "admin@starwars.com",
        },
      ],
    )
    p "Database seeded successfully"
  rescue ActiveRecord::StatementInvalid => e
    p "Seeding failed with error: (#{err}) Rolling back"
  end
end
