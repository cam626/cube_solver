classdef CubeManipulator
    methods (Static)
        function scramble(cube, numMoves)
            scrambleToUse = CubeManipulator.createScramble(numMoves);

            for move = scrambleToUse
                cube.rotate(move);
            end
        end

        function moveList = createScramble(numMoves)
            moves = enumeration('Move');
            moveList = randsample(moves, numMoves);
        end
    end
end

