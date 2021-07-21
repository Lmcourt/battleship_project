require './lib/board'
require './lib/ship'
require './lib/cell'



class Game
  attr_reader :computer_board, :player_board, :ships, :c_submarine, :c_cruiser, :p_submarine, :p_cruiser
  def initialize
    @ships = [Ship.new("Submarine", 2), Ship.new("Cruiser", 3)]
    @computer_board = Board.new
    @player_board = Board.new
    @p_submarine = Ship.new("Submarine", 2)
    @p_cruiser = Ship.new("Cruiser", 3)
  end

 def user_input
   gets.chomp.upcase
 end

 def welcome
   puts "Welcome to BATTLESHIP"
   puts "Enter P to play. Enter Q to quit."
 end

  def start #dont test
    welcome
    player_input = user_input
    until player_input == "P" || player_input == "Q"
      puts "\n Try again..."
      player_input = user_input
    end
    if player_input == "P"
      play_game
    else
      puts "\n Goodbye."
    end
  end

  def play_game
    player_cruiser_placement(p_cruiser)
    player_submarine_placement(p_submarine)
    computer_placement
    until game_over?
      turn
    end
      end_game_message
  end

  def game_over?
    return true if @p_cruiser.health == 0 && @p_submarine.health == 0 || @ships.all? {|ship| ship.health == 0}
  end

  def board_display
    puts " \n ==== DEEP THOUGHT(The great supercomputer) ===="
    puts @computer_board.render
    puts " \n ==== YOU ARE ONLY HUMAN ===="
    puts @player_board.render(true)
  end

  def turn
    player_turn
    computer_turn
    board_display
    # player_turn
  end

  def end_game_message
    # require "pry"; binding.pry
    if @p_cruiser.health == 0 && @p_submarine.health == 0
      puts "\n You have been defeated!"
       # return "You have been defeated!"
    else @ships.all? {|ship| ship.health == 0}
      puts "\n Victory!"
    end
    play_again
  end

  def play_again #dont test
    puts "\n play again, or quit?"
    user_input
      if user_input == "play again"
        start
      elsif user_input == "quit"
        puts "\n peace!"
      else
        puts "That wasn't valid. Goodbye."
      end
  end
def player_cruiser_placement(p_cruiser)
    puts "I put my ships where you will never find them."
    puts "Now it's your turn to place your ships."
    puts "Your cruiser takes 3 coordinates and your submarine takes 2."

    puts "  1 2 3 4 \n"
    puts "A . . . . \n"
    puts "B . . . . \n"
    puts "C . . . . \n"
    puts "D . . . . \n"


    puts "\n Enter the coordinates for your Cruiser"
    # cruiser_answer = gets.chomp
    # @cruiser_coordinates = cruiser_answer.split(", ")
    p_cruiser_coords = user_input.split(" ")
     # require "pry"; binding.pry
    if @player_board.valid_placement?(p_cruiser, p_cruiser_coords) == false
      puts "\n Try again. This time with valid coordinates."
      until @player_board.valid_placement?(p_cruiser, p_cruiser_coords) == true
        p_cruiser_coords.split(" ")
      end
    end
    @player_board.place(p_cruiser, p_cruiser_coords)
  end

  def player_submarine_placement(p_submarine)
    puts "\n Enter the coordinates for your Submarine"
    p_submarine_coords = user_input.split(" ")
    # require "pry"; binding.pry
    # require "pry"; binding.pry
    if @player_board.valid_placement?(p_submarine, p_submarine_coords) == false
      puts "\n Try again. This time with valid coordinates."
      until @player_board.valid_placement?(p_submarine, p_submarine_coords) == true
        p_submarine_coords.split(" ")
      end
    end
    @player_board.place(p_submarine, p_submarine_coords)
  end

  def player_turn
    # require "pry"; binding.pry
    puts "\n Enter a coordinate to find my battleship. Make sure it's valid."
    shoot_coord = user_input
    until @computer_board.valid_coordinate?(shoot_coord) == true  && @computer_board.cells[shoot_coord.to_sym].fired_upon? == false do
      # require "pry"; binding.pry
      puts "\n Waiting for a valid coordinate..."
      shoot_coord = user_input
    end

    @computer_board.cells[shoot_coord.to_sym].fire_upon

    if @computer_board.cells[shoot_coord.to_sym].render == "X"
      puts "\n You shot at #{shoot_coord} GJ."
    elsif computer_board.cells[shoot_coord.to_sym].render == "H"
      puts "\n You shot at #{shoot_coord} and it's a hit. I'm still gonna win."
    elsif computer_board.cells[shoot_coord.to_sym].render == "M"
      puts "\n You missed on #{shoot_coord}. Get owned."
    end
  end

  def computer_placement
    comp_ships = @ships.each do |ship|
      comp_coordinates = @computer_board.cells.keys.sample(ship.length)
      until @computer_board.valid_placement?(ship, comp_coordinates) == true
        comp_coordinates = @computer_board.cells.keys.sample(ship.length)
      end
      @computer_board.place(ship, comp_coordinates)
    end
  end

  def computer_turn
    fired_coord = @player_board.cells.keys.sample
    until @player_board.cells[fired_coord].fired_upon? == false
      fired_coord = @player_board.cells.keys.sample
    end
    @player_board.cells[fired_coord].fire_upon

    if @player_board.cells[fired_coord].render == "X"
      puts "\n I shot at #{fired_coord} GET SUNK."
    elsif @player_board.cells[fired_coord].render == "H"
      puts "\n I shot at #{fired_coord} and it's a hit. I'm gonna win."
    elsif @player_board.cells[fired_coord].render == "M"
      puts "\n I missed at #{fired_coord} but I'm not throwing away my SHOT."
    end
  end
end
