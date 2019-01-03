class Command

  def initialize
    welcome
    main
  end

  def welcome
    puts "Welcome to Main Workout!"
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
                  # "Select Exercise from #{@workouts[input-1].name} to Delete" (list_exercises_by_category(workout, user_integer))
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
                            # (assign_day(workout, user_string))
                              # RETURNS TO VIEW/EDIT PROMPT



  def list_groups
    puts "Select Muscle Group from List:"
    Group.all.each_with_index do |t,i|
      puts "#{i+1}. #{t.name}"
    end
  end


  def list_workouts
    puts "Your Current Workouts:"
    Workout.all.each_with_index do |t,i|
      puts "#{i+1}. #{t.name}"
    end
  end

#combined list_exercises_by_group and list_exercises_by_workout below
  def list_exercises_by_object(object)
    object.exercises.each_with_index do |t,i|
      puts "#{i+1}. #{t.name}"
    end
  end

  def assign_day(workout, day)
    workout.day = day
  end

  def create_workout(name)
    Workout.create(name: name)
  end

  def add_exercise(exercise, workout)
    WorkoutExercise.create(exercise_id: exercise.id, workout_id: workout.id)
  end

  def del_exercise(exercise, workout)
    WorkoutExercise.find_by(exercise_id: exercise.id, workout_id: workout.id).destroy
  end

  def main_options
    puts ""
    puts "1. View or edit existing workout"
    puts "2. Create new workout"

    input = gets.strip

    case input
    when "1"
      puts ""
      puts "Select a workout"

      input = gets.strip
      @workout = @workouts[input.to_i - 1]

      puts ""
      puts "Exercises in #{@workout.name}"

      @workout_exercises = list_exercises_by_object(@workout)

      puts ""
      puts "1. Add exercise to workout"
      puts "2. Delete exercise from workout"

      input = gets.strip

      case input
      when "1"
        @groups = list_groups

        input = gets.strip

        @group = @groups[input.to_i - 1]

        puts ""
        puts "Select exercise:"

        @group_exercises = list_exercises_by_object(@group)

        input = gets.strip

        @exercise = @group_exercises[input.to_i - 1]

        add_exercise(@exercise, @workout)
      when "2"
      else
        puts ""
        puts "Invalid selection"
      end
    when "2"

    else
      puts ""
      puts "Invalid selection"
    end
  end

  def main
    @workouts = list_workouts
    main_options
  end

end
