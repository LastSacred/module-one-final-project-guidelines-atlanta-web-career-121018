require_relative '../config/environment.rb'
require 'csv'

data = CSV.read("data/exercises.csv")

data.each do |pair|
  Group.find_or_create_by(name: pair[1]).exercises << Exercise.find_or_create_by(name: pair[0])
end
