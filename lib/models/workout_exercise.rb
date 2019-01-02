class WorkoutExercise < ActiveRecord::Base
  has_many :exercises
  has_many :workouts
end
