#!/usr/bin/env ruby

def load_numbers(input) 
  results = {}
  
  File.readlines(input).drop(1).each do |line|
    nums = line.split
    date = nums[0]

    results[date] = {}
    results[date]["white_balls"] = nums[1..5].sort
    results[date]["powerball"] =  nums[6]
    results[date]["powerplay"] = nums[7] if nums.length == 8
  end
  
  results
end

def payout_table(white, powerball, powerplay)
  winner = 1

  if white == 5 && powerball
    puts "GRAND PRIZE!!!"
  elsif white == 5
    puts "$1,000,000"
  elsif white == 4 && powerball
    puts "$50,000"
  elsif white == 4
    puts "$100"
  elsif white == 3 && powerball
    puts "$100"
  elsif white == 3
    puts "$7"
  elsif white == 2 && powerball
    puts "$7"
  elsif white == 1 && powerball
    puts "$4"
  elsif powerball
    puts "$4"
  else
    winner = 0
  end
  
  winner
end

def match_numbers(new_numbers, results)
  nums = new_numbers.split
  date = nums[0]
  white_balls = nums[1..5].sort
  powerball = nums[6]
  powerplay = nums[7] if nums.length == 8

  white_ball_matches = (white_balls & results[date]['white_balls']).length
  powerball_match = powerball == results[date]['powerball']
  powerplay_match = powerplay == results[date]['powerplay'] if powerplay

  payout_table(white_ball_matches, powerball_match, powerplay_match)
end

winning_numbers = load_numbers('winnums-text.txt')
my_nums = 'my_nums'

File.readlines(my_nums).drop(1).each do |line|
  puts line if match_numbers(line, winning_numbers) == 1
end
