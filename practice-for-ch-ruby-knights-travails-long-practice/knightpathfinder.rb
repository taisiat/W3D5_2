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

    def initialize(starting_pos) #[num, num]
        @considered_positions = [starting_pos]
    end

    def new_move_positions(pos)
        valid = KnightPathFinder.valid_moves(pos)
        valid_subset = valid.select do |option|
            !@considered_positions.include?(option)
        end

        @considered_positions += valid_subset
        valid_subset
    end

    def build_move_tree #instance
         queue = [@considered_positions.first]

         until queue.empty? 
            p queue
            node = queue.shift
            KnightPathFinder.new(node)
            queue += new_move_positions(node)
         end

         p queue
    end
end