require 'byebug'
require_relative '00_tree_node'
require_relative 'knightstravails'
require_relative 'board'
class KnightPathFinder

    def self.valid_moves(pos)# array of pos[0,0] row and col
        #[2,1],[1,2],[-1,-2],[-2,-1],[2,-1],[1,-2],[-1,2],[-2,1]
        @considered_positions = pos
        row,col = pos
        real_pos = [[row + 2, col + 1], [row + 1, col + 2], [row - 1, col -2], 
            [row - 2, col - 1], [row + 2, col - 1], [row + 1, col - 2], [row - 1, col + 2], [row - 2, col + 1]]
        real_pos.select{|ele|
                ro, co = ele
                ro < 8 && ro > -1 && co < 8 && co > -1
            }
        # real_pos
    end

    def initialize(start_pos)
        @start_pos = start_pos
        # @board = Board.new
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(start_pos)
    end

    def new_move_positions(pos)
        new_pos = KnightPathFinder.valid_moves(pos).select{|ele|!considered_positions.include?(ele)}
        considered_positions += new_pos
        new_pos
    end
    private
    attr_reader :start_pos, :considered_positions
end