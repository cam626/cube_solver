classdef Move
    enumeration
        Up
        Up2
        Down
        Down2
        Left
        Left2
        Right
        Right2
        Front
        Front2
        Back
        Back2
    end

    methods
        function strName = toStr(move)
            switch move
                case Move.Up
                    strName = "Up";
                case Move.Down
                    strName = "Down";
                case Move.Left
                    strName = "Left";
                case Move.Right
                    strName = "Right";
                case Move.Front
                    strName = "Front";
                case Move.Back
                    strName = "Back";
            end
        end

        function res = is2Move(move)
            res = ismember(move, [Move.Up2 Move.Down2 Move.Left2 Move.Right2 Move.Front2 Move.Back2]);
        end
    end
end