require 'io/console'

MESSAGE_HOW_TO_PLAY = "move the cursor with the arrow keys and press enter to draw "

class TicTacToeBoard

  attr_accessor :board

  def initialize
    self.board = build_board
  end

  def draw_on_board(player_name, token)
    # pos = position
    pos = {x: 0, y: 0}
    while true
      board[pos[:y]][pos[:x]][0] = ">"
      print_board player_name
      board[pos[:y]][pos[:x]][0] = " "

      # exit if the player presses any key other than the arrow keys
      keydown = $stdin.getch
      unless keydown == "\e"
        break if board[pos[:y]][pos[:x]][1] == " "
        next
      end
      keydown += $stdin.getch + $stdin.getch

      case keydown
      when "\e[C" then pos[:x] += 1 if pos[:x] < 2
      when "\e[D" then pos[:x] -= 1 if pos[:x] > 0
      when "\e[B" then pos[:y] += 1 if pos[:y] < 2
      when "\e[A" then pos[:y] -= 1 if pos[:y] > 0
      else break
      end
    end
    board[pos[:y]][pos[:x]][1] = token
    print_board player_name
  end

  def to_s
    board.map do |row|
      ("|" + row.map { |e| "#{e} |"}.join).center(`tput cols`.to_i) + "\n" + ("-" * 13).center(`tput cols`.to_i) + "\n"
    end.join
  end

  def print_board(player_name)
    # clean the console and print the board
    system("clear")
    puts (player_name + " turn").center(`tput cols`.to_i - 1) + "\n\n\n" + to_s + "\n\n"
    puts MESSAGE_HOW_TO_PLAY.center(`tput cols`.to_i)
  end

  def did_the_player_win?(token)
    diagonal_count = [0, 0]
    (0..2).each { |i|
      count = [0, 0]
      (0..2).each { |j|
        count[0] += 1 if board[i][j][1] == token
        count[1] += 1 if board[j][i][1] == token
      }
      return true if count[0] == 3 || count[1] == 3
      diagonal_count[0] += 1 if board[i][i][1] == token
      diagonal_count[1] += 1 if board[2 - i][i][1] == token
    }
    return true if diagonal_count[0] == 3 || diagonal_count[1] == 3
    false
  end


  def is_full?
    !board.any? { |row| row.any? { |elem| elem == '  '}}
  end

  private
  def build_board
    Array.new(3) {["  ", "  ", "  "]}
  end
end


