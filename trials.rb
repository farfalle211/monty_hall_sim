class MontyHall
  attr_accessor :doors, :initial_pick, :initial_pick_index, :final_choice

  # @@swap_win_counter = 0
  # @@no_swap_win_counter = 0
  # @@total_no_swap_runs = 0
  # @@total_swap_runs = 0

  def initialize
    @doors = ["goat", "goat", "car"].shuffle
    @initial_pick_index = rand(2)
    @initial_pick = doors[initial_pick_index]
  end

  def reveal_door
    #Find the index of the revealed door
    #Cannot be the player's original choice or door with the car behind it
    door_indexes = [0, 1, 2]
    door_indexes -= [initial_pick_index, doors.index("car")]
    @revealed_door = door_indexes.shuffle.first
  end

  def no_swap_win?
    final_choice = initial_pick
    won?(final_choice)
  end

  def swap_win?
    swapped_index = ([0, 1, 2] - [initial_pick_index, @revealed_door]).first
    final_choice = doors[swapped_index]
    won?(final_choice)
  end

  def won?(final_choice)
    final_choice == "car"
  end
end

class Tester
  attr_accessor :swap_wins, :no_swap_wins, :trials

  def initialize
    @swap_wins = 0
    @no_swap_wins = 0
    @trials = 10000

    @trials.times do
      monty_hall = MontyHall.new
      monty_hall.reveal_door
      @swap_wins += 1 if monty_hall.swap_win?
      @no_swap_wins += 1 if monty_hall.no_swap_win?
    end
    calulate_win_stats
  end

  def calulate_win_stats
    @swap_win_percent = (swap_wins.to_f / trials) * 100
    @no_swap_win_percent = (no_swap_wins.to_f / trials) * 100
  end

  def print_results
    puts "Swap win percent is #{@swap_win_percent.round(2)}%"
    puts "No Swap win percent is #{@no_swap_win_percent.round(2)}%"
  end

  def send_results
    File.open("results.jpg", "w") {|f| f.write "#{print_results}"}
  end
end

tester = Tester.new
tester.send_results

# MontyHall.run
# MontyHall.stats

# input = 3
# string = "p 'hello' * #{input}"
# eval(string)