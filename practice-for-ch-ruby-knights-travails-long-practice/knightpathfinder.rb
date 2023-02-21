require_relative "tree_node"

class KnightPathFinder
    DELTAS = [[2, -1], [2, 1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, -2], [-1, 2]]
    def self.valid_moves(pos)
        moves = []
        x, y = pos
        DELTAS.each do |delta|
            x_d, y_d = delta
            if (x + x_d < 8 && y + y_d < 8) && (x + x_d > -1 && y + y_d > -1)
                moves.push([x + x_d, y + y_d])
            end
        end
        moves
    end
    attr_reader :considered_positions
    def initialize(starting_pos) #[num, num]
        @considered_positions = [starting_pos]
        @root_node = PolyTreeNode.new(starting_pos)
        self.build_move_tree
    end

    def new_move_positions(pos)
        valid = KnightPathFinder.valid_moves(pos)
        valid_subset = valid.select do |option|
            !@considered_positions.include?(option)
        end
        @considered_positions += valid_subset
        valid_subset
    end

    def build_move_tree
         queue = [@root_node] #inst
        until queue.empty? 
            node = queue.shift #inst
            children = new_move_positions(node.value)
            child_inst_arr = children.map { |child| PolyTreeNode.new(child) }
            child_inst_arr.each do |child_inst|
                child_inst.parent = node
                queue << child_inst
            end
        end

        #  p queue
    end

    def find_path(end_pos) #coord
    # goal: find inst that matches end pos, use exiting methods, looking at children
        end_node = @root_node.dfs(end_pos)
        trace_path_back(end_node)
    end

    def trace_path_back(end_pos_node)
         #helped for find path, looking at parents, reverse path
        path = []
        current_node = end_pos_node
        until current_node == @root_node
            path << current_node.value
            current_node = current_node.parent
        end
        path.reverse
    end
end