namespace :db do
  # display a message if the versions don't match
  # don't fail the task since some versions may produce identical results
  def check_version
    current_version = ActiveRecord::Base.connection.select_value("SHOW server_version")
    specified_version = asdf_version

    if current_version != specified_version
      puts "You are running postgres #{current_version} instead of #{specified_version}"
      puts "This may produce a different structure.sql file"
    end
  end

  def asdf_version
    File.open("./.tool-versions").each_line do |line|
      line.match(/^postgres\s+([0-9.]+)/) { |match| return match[1] }
    end
  end

  desc "generate structure.sql and schema.rb from a fresh database"
  task fix_structure: :environment do
    db = "#{Rails.env}_clean"
    config = Rails.configuration.database_configuration[db]

    if !config
      raise "Define an entry named '#{db}' in database.yml"
    end

    ActiveRecord::Tasks::DatabaseTasks.drop config
    ActiveRecord::Tasks::DatabaseTasks.create config

    ActiveRecord::Base.establish_connection(db.to_sym).connection
    ActiveRecord::Tasks::DatabaseTasks.migrate

    # Generate structure.sql
    filename = ENV["SCHEMA"] || File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, "structure.sql")
    ActiveRecord::Tasks::DatabaseTasks.structure_dump config, filename

    File.open(filename, "a") do |f|
      f.puts ActiveRecord::Base.connection.dump_schema_information
      f.print "\n"
    end

    # Disable any statement creating the public schema
    # This gets added starting in postgresql 11 and breaks db:schema_load
    schema = File.read(filename)
    schema.sub!(/^CREATE SCHEMA public/, "-- CREATE SCHEMA public")
    File.write(filename, schema)

    # Generate schema.rb
    ActiveRecord::Base.schema_format = :ruby
    Rake::Task["db:schema:dump"].invoke

    ActiveRecord::Base.schema_format = Rails.application.config.active_record.schema_format

    check_version
  end
end
