classdef Utils
    methods (Static)
        function dispMoveList(moveList)
            for moveNum = numel(moveList)
                move = moveList(moveNum);

                disp(Utils.moveName(move));
            end
        end

        function name = moveName(move)
            name = move.toStr();
        end

        function invertedMoveList = invertMoveList(moveList)
            invertedMoveList = zeros(1, numel(moveList));

            for moveNum = 1:numel(moveList)
                move = moveList(moveNum);
                invertedMoveList(numel(moveList)-moveNum+1) = move.getInvertMove();
            end
        end

    end
end

