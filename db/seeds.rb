unless Rails.env.production?
  Planet.destroy_all
  Person.destroy_all
  Film.destroy_all

  connection = ActiveRecord::Base.connection

  sql = File.read('db/populate.sql')
  statements = sql.split(/;$/)
  statements.pop

  begin
    ActiveRecord::Base.transaction do
      statements.each do |statement|
        connection.execute(statement)
      end
    end
    p "Database seeded successfully"
  rescue ActiveRecord::StatementInvalid => err
    ActiveRecord::Rollback
    p "Seeding failed with error: (#{err.to_s}) Rolling back"
  end
end
