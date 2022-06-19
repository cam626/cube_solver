classdef Move < uint32
    enumeration
        Up      (1)
        Up2     (2)
        Down    (3)
        Down2   (4)
        Left    (5)
        Left2   (6)
        Right   (7)
        Right2  (8)
        Front   (9)
        Front2  (10)
        Back    (11)
        Back2   (12)
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
                case Move.Up2
                    strName = "Up2";
                case Move.Down2
                    strName = "Down2";
                case Move.Left2
                    strName = "Left2";
                case Move.Right2
                    strName = "Right2";
                case Move.Front2
                    strName = "Front2";
                case Move.Back2
                    strName = "Back2";
            end
        end

        function int = toInt(move)
            int = uint32(move);
        end

        function res = is2Move(move)
            res = ismember(move, [Move.Up2 Move.Down2 Move.Left2 Move.Right2 Move.Front2 Move.Back2]);
        end
    
        function altMove = getAltMove(move)
            if move.is2Move()
                altMove = move.getSingleVersion();
            else
                altMove = move.getDoubleVersion();
            end
        end

        function doubleMove = getDoubleVersion(move)
            switch move
                case Move.Up
                    doubleMove = Move.Up2;
                case Move.Down
                    doubleMove = Move.Down2;
                case Move.Left
                    doubleMove = Move.Left2;
                case Move.Right
                    doubleMove = Move.Right2;
                case Move.Front
                    doubleMove = Move.Front2;
                case Move.Back
                    doubleMove = Move.Back2;
            end
        end

        function doubleMove = getSingleVersion(move)
            switch move
                case Move.Up2
                    doubleMove = Move.Up;
                case Move.Down2
                    doubleMove = Move.Down;
                case Move.Left2
                    doubleMove = Move.Left;
                case Move.Right2
                    doubleMove = Move.Right;
                case Move.Front2
                    doubleMove = Move.Front;
                case Move.Back2
                    doubleMove = Move.Back;
            end
        end
    end
end