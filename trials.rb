### Solution to the Monty Hall Problem
### Author: Michael Dessailly, email: dessaillym@gmail.com
### Date: 12/27/2019

class MontyHall

  #Shuffle the arrangement behind the doors
  #Randomize the initial selection of the player
  def initialize
    @doors = [:goat, :goat, :car].shuffle
    @initial_pick_index = rand(3)
    @initial_pick = @doors[@initial_pick_index]
    @revealed_door = ""
    reveal_door
  end

  #True if the initial pick is the car
  def no_swap_win?
    final_choice = @initial_pick
    won?(final_choice)
  end

  #True if swapping results in the car
  #Find the index of Swap option; this isn't the initial pick or the revealed door
  def swap_win?
    swapped_index = ([0, 1, 2] - [@initial_pick_index, @revealed_door]).first
    final_choice = @doors[swapped_index]
    won?(final_choice)
  end

  #True if the final choice is a car
  def won?(final_choice)
    final_choice == :car
  end

  private

  #Find the index of the host's revealed door
  #This cannot be the player's original choice or the door with the car behind it
  def reveal_door
    door_indexes = [0, 1, 2]
    door_indexes -= [@initial_pick_index, @doors.index(:car)]
    @revealed_door = door_indexes.shuffle.first
  end
end

class Tester

  #Initialize a counter for swap wins and no_swap wins
  #Run the MontyHall simulation @trials times and track swap/no_swap wins
  def initialize
    @swap_wins = 0
    @no_swap_wins = 0
    @trials = 10000

    @trials.times do
      monty_hall = MontyHall.new
      @swap_wins += 1 if monty_hall.swap_win?
      @no_swap_wins += 1 if monty_hall.no_swap_win?
    end
    calulate_win_stats
    send_results
  end

  private

  #Obtain win percentages for swap/no_swap scenarios
  def calulate_win_stats
    @swap_win_percent = (@swap_wins.to_f / @trials) * 100
    @no_swap_win_percent = (@no_swap_wins.to_f / @trials) * 100
  end

  def swap_results
    "Swap win percent is #{@swap_win_percent.round(2)}%"
  end

  def no_swap_results
    "No Swap win percent is #{@no_swap_win_percent.round(2)}%"
  end

  #Write results to results.txt file
  def send_results
    File.open("results.txt", "w") do |file| 
      file.write "#{swap_results}\n"
      file.write "#{no_swap_results}"
    end
  end
end

tester = Tester.new