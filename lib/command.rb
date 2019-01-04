class Command

#INITIALIZE
  def initialize
    welcome
    main
  end


#HELPER METHODS
  def welcome
    puts ""
    puts "Welcome to Workout Builder!"
  end

  def list_groups
    puts ""
    puts "SELECT MUSCLE GROUP FROM LIST:"
    Group.all.each_with_index do |t,i|
      puts "  #{i+1}. #{t.name}"
    end
  end

  def list_workouts
    puts ""
    puts "MAIN MENU"
    puts "Your Current Workouts:"
    Workout.all.each_with_index do |t,i|
      puts "  #{i+1}. #{t.name}"
    end
  end

  def list_exercises_by_object(object)
    object.exercises.each_with_index do |t,i|
      puts "  #{i+1}. #{t.name}"
    end
  end

  def assign_day(workout, day)
    workout.day = day
    workout.save
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
    @workouts = list_workouts
      puts ""
      puts "SELECT FROM THE FOLLOWING OPTIONS:"
      puts "  (1) View or Edit Existing Workout"
      puts "  (2) Create New Workout"
      puts ""
    input = gets.strip
  end

  def grab_workout
      puts ""
      puts "SELECT A WORKOUT"
      puts "Your Current Workouts:"
      Workout.all.each_with_index do |t,i|
        puts "  #{i+1}. #{t.name}"
      end
      puts ""
    input = gets.strip
  end

  def add_delete_assign(input)
    @workout = @workouts[input.to_i - 1]
      puts ""
      puts "Exercises in #{@workout.name} (#{@workout.day}):"
    @workout_exercises = list_exercises_by_object(@workout)
      puts ""
      puts "SELECT FROM THE FOLLOWING OPTIONS:"
      puts "  (1) Add Exercise to Workout"
      puts "  (2) Delete Exercise from Workout"
      puts "  (3) Assign Day to Workout"
      puts ""
    input = gets.strip
  end

  def grab_group
    @groups = list_groups
    puts ""
    input = gets.strip
  end

  def grab_exercise(input)
    @group = @groups[input.to_i - 1]
      puts ""
      puts "SELECT EXERCISE TO ADD:"
    @group_exercises = list_exercises_by_object(@group)
      puts ""
    input = gets.strip
  end

  def add_for_user(input)
    @exercise = @group_exercises[input.to_i - 1]
    add_exercise(@exercise, @workout)
    @workout = Workout.find(@workout.id)
      puts ""
      puts "Exercises in #{@workout.name}:"
    @workout_exercises = list_exercises_by_object(@workout)
  end

  def grab_to_delete
      puts ""
      puts "SELECT EXERCISE TO DELETE:"
      puts ""
    input = gets.strip
  end

  def delete_for_user(input)
    @exercise = @workout_exercises[input.to_i - 1]
    del_exercise(@exercise, @workout)
    @workout = Workout.find(@workout.id)
    puts "Exercises in #{@workout.name}:"
    @workout_exercises = list_exercises_by_object(@workout)
  end

  def grab_day
      puts ""
      puts "ENTER DAY"
      puts ""
    input = gets.strip
  end

  def assign_for_user(input)
    assign_day(@workout, input)
    @workout = Workout.find(@workout.id)
      puts ""
      puts "#{@workout.name} now assigned to #{@workout.day}"
  end

  def invalid_selection
    puts ""
    puts "INVALID SELECTION"
  end

  def grab_new_wo
      puts ""
      puts "ENTER NAME OF WORKOUT"
      puts ""
    input = gets.strip
  end


#COMMAND LINE INTERFACE
  def main
    loop do
      input1 = main_options
      case input1
      when "exit"
        exit
      when "1" #View/Edit Workout
        loop do
          input2 = grab_workout
          break if input2 == "back"
          exit if input2 == "exit"
          input3 = add_delete_assign(input2)
          case input3
          when "exit"
            exit
          when "back"
            break
          when "1" #add exercise to workout
            loop do
              input4 = grab_group
                break if input4 == "back"
                exit if input4 == "exit"
              input5 = grab_exercise(input4)
                break if input5 == "back"
                exit if input5 == "exit"
              add_for_user(input5)
            end
          when "2" #delete exercise from workout
            loop do
              input6 = grab_to_delete
                break if input6 == "back"
                exit if input6 == "exit"
              delete_for_user(input6)
            end
          when "3" #assign day to workout
            input7 = grab_day
              break if input7 == "back"
              exit if input7 == "exit"
            assign_for_user(input7)
          else
            invalid_selection
          end
        end
      when "2" #Create new workout
        input8 = grab_new_wo
          next if input8 == "back"
          exit if input8 == "exit"
        create_workout(input8)
      else
        invalid_selection
      end
    end
  end

end
