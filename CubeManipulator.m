classdef CubeManipulator
    methods (Static)
        function moveList = scramble(cube, numMoves)
            moveList = CubeManipulator.createScramble(numMoves);
            CubeManipulator.applyMoveList(cube, moveList);
        end

        function moveList = createScramble(numMoves)
            moveList = cell(numMoves, 2);

            moves = enumeration('Move');
            for moveNum = 1:numMoves
                currentMove = randsample(moves, 1);
                primeFlag = logical(randi(2) - 1);

                if moveNum ~= 1
                    lastMove = moveList{moveNum-1, 1};
                    lastPrimeFlag = moveList{moveNum-1, 2};

                    if lastMove == currentMove && lastPrimeFlag ~= primeFlag
                        primeFlag = abs(primeFlag-1);
                    end
                end

                moveList{moveNum, 1} = currentMove;
                moveList{moveNum, 2} = primeFlag;
            end
        end

        function applyMoveList(cube, moveList)
            for moveNum = 1:size(moveList, 1)
                cube.rotate(moveList{moveNum, 1}, moveList{moveNum, 2});
            end
        end
    end
end

