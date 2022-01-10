require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return board.winner != evaluator && board.won?
    end

    if next_mover_mark == evaluator
      self.children.all? do |child|
        child.losing_node?(evaluator)
      end
    else
      self.children.any? do |child|
        child.losing_node?(evaluator)
      end
    end

  end

  def winning_node?(evaluator)
    if board.over?
      return board.winner == evaluator
    end

    if next_mover_mark == evaluator
      self.children.any? do |child|
        child.winning_node?(evaluator)
      end
    else
      self.children.all? do |child|
        child.winning_node?(evaluator)
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    (0..2).each do |idx1|
      (0..2).each do |idx2|
        pos = [idx1,idx2]
        if board.empty?(pos)
          nextBoard = board.dup
          nextBoard[pos] = next_mover_mark
          next_mover_mark = (self.next_mover_mark == :x ? :o : :x)
          child = TicTacToeNode.new(nextBoard, next_mover_mark, pos)
          children.push(child)
        end
      end
    end
    children
  end


end
