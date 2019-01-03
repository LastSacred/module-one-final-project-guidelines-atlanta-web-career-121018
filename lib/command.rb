class Command

  def assign_day(workout, day)
    workout.day = day
  end

  def create_workout(name)
    Workout.create(name: name)
  end

  def add_exercise(exercises, ex_int, workouts, wo_int)
    exercise = exercises[ex_int - 1]
    workout = workouts[wo_int - 1]

    WorkoutExercise.create(exercise_id: exercise.id, workout_id: workout.id)
  end

  def del_exercise(exercise, ex_int, workout, wo_int)
    exercise = exercises[ex_int - 1]
    workout = workouts[wo_int - 1]

    WorkoutExercise.find_by(exercise_id: exercise.id, workout_id: workout.id).destroy
  end

end
