classdef Utils
    methods (Static)
        function dispMoveList(moveList)
            for moveNum = 1:size(moveList, 1)
                move = moveList{moveNum, 1};
                primeFlag = moveList{moveNum, 2};

                disp(Utils.moveName(move, primeFlag));
            end
        end

        function name = moveName(move, primeFlag)
            name = move.toStr();

            if primeFlag
                name = strcat(name, " Prime");
            end
        end
    end
end

