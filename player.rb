# frozen_string_literal: true
MESSAGE_ENTER_NAME = "Enter the name of player "
class Player

  attr_accessor :name, :token
  def initialize(name, token)
    self.name = name
    self.token = token
  end

  def play_turn(board)
    board.draw_on_board(name, token)
  end

  def has_won?(board)
    board.did_the_player_win?(token)
  end

  def print_winning_message
    puts ""
    puts "The player #{name} has won".center(`tput cols`.to_i)
  end

  def self.enter_name(number = 1)
    puts MESSAGE_ENTER_NAME + "#{number}: "
    gets.chomp
  end
end
