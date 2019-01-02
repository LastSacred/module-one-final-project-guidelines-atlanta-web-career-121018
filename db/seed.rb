require_relative '../config/environment.rb'
require 'csv'

data = CSV.read("data/exercises.csv")

data.each do |pair|
  exercise = Exercise.find_or_create_by(name: pair[0])
  exercise.group = Group.find_or_create_by(name: pair[1])
end

binding.pry
