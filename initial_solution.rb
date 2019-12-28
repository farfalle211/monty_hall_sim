### Solution to Monty Hall Problem

no_swap_win_counter = 0
swap_win_counter = 0
total_swap_runs = 0
total_no_swap_runs = 0

options = ["goat", "goat", "car"]

10000.times do
  options.shuffle!

  user_selection = options[rand(3)]

  #randomize whether a user Swaps or Doesn't Swap

  swap_randomizer = ["swap", "no_swap"].sample

  if swap_randomizer == "no_swap"
    if user_selection == "car"
      no_swap_win_counter += 1
    end
    total_no_swap_runs += 1
  else  
    if user_selection == "goat"
      swap_win_counter += 1
    end
    total_swap_runs +=1
  end
end

swap_win_percent = (swap_win_counter.to_f / total_swap_runs).round(2) * 100

no_swap_win_percent = (no_swap_win_counter.to_f / total_no_swap_runs).round(2) * 100

puts "If you Swap your win rate is #{swap_win_percent}%"
puts "If you Don't Swap your win rate is #{no_swap_win_percent}%"
