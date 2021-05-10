require 'byebug'
require_relative '00_tree_node'
require_relative 'knightstravails'
require_relative 'board'
require 'set'
class KnightPathFinder

    def self.valid_moves(pos)# array of pos[0,0] row and col
        #[2,1],[1,2],[-1,-2],[-2,-1],[2,-1],[1,-2],[-1,2],[-2,1]
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
        @considered_positions = [start_pos]
        build_move_tree
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(start_pos)
        nodes = [root_node] # node instance  
        i = 0
        while (i < nodes.length)
            ele = nodes.shift
            pos = new_move_positions(ele.value)
            #######
            current_node = PolyTreeNode.new(ele)
            pos.each do |po|
                 node = PolyTreeNode.new(po)
                 node.parent = current_node
                 nodes << node
            end 
        end 
    end

    def new_move_positions(pos)
        new_pos = KnightPathFinder.valid_moves(pos).select{|ele|!considered_positions.include?(ele)}
        @considered_positions += new_pos
    end
    # private 
    attr_reader :root_node, :considered_positions, :start_pos
    attr_writer :root_node
end