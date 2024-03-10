require_relative 'player'
require_relative 'tic_tac_toe_board'

def loop_game
  board = TicTacToeBoard.new
  player1 = Player.new(Player.enter_name(1), "O")
  player2 = Player.new(Player.enter_name(2), "x")
  players = {1 => player1, -1 => player2}
  current = 1
  while true
    if players[current].play_turn(board)
      players[current].print_winning_message
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

