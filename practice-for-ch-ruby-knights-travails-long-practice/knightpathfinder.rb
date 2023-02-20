require_relative
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
         queue = [@considered_positions.first]

         until queue.empty? 
            # p queue
            node = queue.shift
            PolyTreeNode.new(node)
            queue += new_move_positions(node)
         end

        #  p queue
    end

    def find_path(end_pos)
        # root_tree = self.build_move_tree
        
        queue = [self]
        until queue.empty?
            node = queue.shift
            return node if node.considered_positions.first == end_pos
            node_children_pos = new_move_positions(node)
            node_children_instances = node_children_pos.map { |pos| KnightPathFinder.new(pos)}
            queue.concat(node_children_instances)
        end
        nil
    end
end