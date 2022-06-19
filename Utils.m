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
    end
end

