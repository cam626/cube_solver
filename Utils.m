classdef Utils
    methods (Static)
        function applyMoveList(cube, moveList)
            for moveNum = 1:size(moveList, 1)
                cube.rotate(moveList{moveNum, 1}, moveList{moveNum, 2});
            end
        end

        function dispMoveList(moveList)
            for moveNum = 1:size(moveList, 1)
                move = moveList{moveNum, 1};
                primeFlag = moveList{moveNum, 2};

                disp(Utils.moveName(move, primeFlag));
            end
        end

        function name = moveName(move, primeFlag)
            name = move.toStr();

            if primeFlag && ~move.is2Move()
                name = strcat(name, " Prime");
            end
        end

        function invertedMoveList = invertMoveList(moveList)
            invertedMoveList = cell(size(moveList));
            
            for moveIndex = 1:size(moveList, 1)
                move = moveList{moveIndex, 1};
                primeFlag = moveList{moveIndex, 2};

                flippedPrimeFlag = abs(primeFlag-1);

                invertedMoveIndex = size(invertedMoveList, 1) - moveIndex + 1;
                
                invertedMoveList{invertedMoveIndex, 1} = move;
                invertedMoveList{invertedMoveIndex, 2} = flippedPrimeFlag;
            end
        end
    end
end

