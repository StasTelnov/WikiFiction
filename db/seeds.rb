# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require "csv"

def get_from_file(model)
  file      = model.name.underscore
  file_path = Rails.root.join("db","seeds", "#{file}.csv").to_path
  CSV.foreach(file_path, { :headers => true }) do |row|
    model.create_with(row.to_hash).find_or_create_by(:code => row.to_hash['code'])
  end
  puts "[#{model.name}] was populated"
end

puts "======================================SEED DATA START POPULATED============================================="

Rake::Task["demo:clear"].execute

[
  Category
].map do |model|
  get_from_file(model)
end

puts "======================================SEED DATA FINISH POPULATED============================================="
