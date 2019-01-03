class Command

  def initialize
    
  end
  #everytime we run, we make a new Command instance that runs CLI
    # start

    # welcome message
    # "Your Current Workouts" (list_workouts)
    # 1. ...
    # 2. ...
    # 3. ...
    # "OPTIONS"

    # (1) View or Edit Existing Workout
      # *User types in '1'*
        # "Select Workout from List" (list_workouts)
        # 1. ...
        # 2. ...
        # 3. ...
          # *User types in integer*
            # "Exercises from #{workout.name}" (list_exercises_by_category(workout, user_integer))
              # 1. ...
              # 2. ...
              # 3. ...
              # "OPTIONS"

              # (1) "Add Exercise to Workout"
                # *User types in '1'
                  # "Select Muscle Group from List" (list_groups)
                  # 1. ...
                  # 2. ...
                  # 3. ...
                    # *User types in integer*
                      # "Select Exercise from List" (list_exercises_by_category(group, user_integer))
                      # 1. ...
                      # 2. ...
                      # 3. ...
                        # *User types in integer*
                          # (add_exercise(exercises, ex_int, workouts, wo_int))
                            # RETURNS TO VIEW/EDIT PROMPT

              # (2) "Delete Exercise from Workout"
                # *User types in '2'
                  # "Select Exercise from #{workout.name} to Delete" (list_exercises_by_category(workout, user_integer))
                  # 1. ...
                  # 2. ...
                  # 3. ...
                    # *User types in integer*
                      # (del_exercise(exercises, ex_int, workouts, wo_int))
                        # RETURNS TO VIEW/EDIT PROMPT

              # (3) "Assign Day to Workout"
                # *User types in '3'
                  # "Select Workout from List" (list_workouts)
                  # 1. ...
                  # 2. ...
                  # 3. ...
                    # *User types in integer*
                      # "#{workout.name}: "
                      # "Type in Day"
                        # *User types in string*
                          # (assign_day(user_int, workouts, user_string))
                            # RETURNS TO VIEW/EDIT PROMPT

    # (2) Create New Workout
      # *User types in '2'*
        # "What would you like to name this workout?"
          # *User types in string*
            # (create_workout(user_string))

              # "Exercises from #{workout.name}" (list_exercises_by_category(workout, user_integer))
                # 1. ...
                # 2. ...
                # 3. ...
                # "OPTIONS"

                # (1) "Add Exercise to Workout"
                  # *User types in '1'
                    # "Select Muscle Group from List" (list_groups)
                    # 1. ...
                    # 2. ...
                    # 3. ...
                      # *User types in integer*
                        # "Select Exercise from List" (list_exercises_by_category(group, user_integer))
                        # 1. ...
                        # 2. ...
                        # 3. ...
                          # *User types in integer*
                            # (add_exercise(exercises, ex_int, workouts, wo_int))
                              # RETURNS TO VIEW/EDIT PROMPT
                # (2) "Delete Exercise from Workout"
                  # *User types in '2'
                    # "Select Exercise from #{workout.name} to Delete" (list_exercises_by_category(workout, user_integer))
                    # 1. ...
                    # 2. ...
                    # 3. ...
                      # *User types in integer*
                        # (del_exercise(exercises, ex_int, workouts, wo_int))
                          # RETURNS TO VIEW/EDIT PROMPT
                # (3) "Assign Day to Workout"
                  # *User types in '3'
                    # "Select Workout from List" (list_workouts)
                    # 1. ...
                    # 2. ...
                    # 3. ...
                      # *User types in integer*
                        # "#{workout.name}: "
                        # "Type in Day"
                          # *user types in string*
                            # (assign_day(user_int, workouts, user_string))
                              # RETURNS TO VIEW/EDIT PROMPT



  def list_groups
    Group.all.each_with_index do |t,i|
      puts "#{i+1}. #{t.name}"
    end
  end

  # def list_exercises_by_group(groups,int)
  #   index = int - 1
  #   exercises = groups[index].exercises
  #   exercises.each_with_index do |t,i|
  #     puts "#{i+1}. #{t.name}"
  #   end
  #   exercises
  # end

  def list_workouts
    Workout.all.each_with_index do |t,i|
      puts "#{i+1}. #{t.name}"
    end
  end

  # def list_exercises_by_workout(workouts,int)
  #   index = int - 1
  #   exercises = workouts[index].exercises
  #   exercises.each_with_index do |t,i|
  #     puts "#{i+1}. #{t.name}"
  #   end
  #   exercises
  # end

#combined list_exercises_by_group and list_exercises_by_workout below
  def list_exercises_by_category(array,int)
    index = int - 1
    array[index].exercises.each_with_index do |t,i|
      puts "#{i+1}. #{t.name}"
    end
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
