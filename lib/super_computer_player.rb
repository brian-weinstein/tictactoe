require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    tttnode = TicTacToeNode.new(game.board,mark)
    moves = tttnode.children
    tttnode = moves.find{|child|child.winning_node?(mark)}

    if tttnode != nil
      return tttnode.prev_move_pos
    end
    tttnode = moves.find{|child|!child.losing_node?(mark)}
    if tttnode !=nil
      return tttnode.prev_move_pos
    end

    raise "Error: AI Should be unable to lose"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
