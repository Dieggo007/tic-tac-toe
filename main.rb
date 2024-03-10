require './player.rb'
require './tic_tac_toe_board.rb'

def loop_game
  board = TicTacToeBoard.new
  player1 = Player.new(Player.enter_name(1), "O")
  player2 = Player.new(Player.enter_name(2), "x")
  player = {1 => player1, -1 => player2}
  current = 1
  while true
    player[current].play_turn(board)
    if player[current].has_won?(board)
      player[current].print_winning_message
      break
    elsif board.is_full?
      puts ""
      puts "the game has ended in a tie".center(`tput cols`.to_i)
      break
    end
    current *= -1
  end
end

loop_game

