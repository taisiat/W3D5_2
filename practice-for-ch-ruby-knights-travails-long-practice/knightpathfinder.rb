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
        
    end
end