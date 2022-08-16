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
        UpPrime (13)
        DownPrime (14)
        LeftPrime (15)
        RightPrime (16)
        FrontPrime (17)
        BackPrime (18)
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
                case Move.UpPrime
                    strName = "UpPrime";
                case Move.DownPrime
                    strName = "DownPrime";
                case Move.LeftPrime
                    strName = "LeftPrime";
                case Move.RightPrime
                    strName = "RightPrime";
                case Move.FrontPrime
                    strName = "FrontPrime";
                case Move.BackPrime
                    strName = "BackPrime";
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
    
        function sameFaceMoves = getSameFaceMoves(move)
            if move.is2Move()
                sameFaceMoves = [move.getSingleVersion(), ...
                                 move.getPrimeVersion()];
            else
                sameFaceMoves = [move.getDoubleVersion(), ...
                                 move.getInvertMove()];
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
                case Move.UpPrime
                    doubleMove = Move.Up2;
                case Move.DownPrime
                    doubleMove = Move.Down2;
                case Move.LeftPrime
                    doubleMove = Move.Left2;
                case Move.RightPrime
                    doubleMove = Move.Right2;
                case Move.FrontPrime
                    doubleMove = Move.Front2;
                case Move.BackPrime
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

        function primeMove = getPrimeVersion(move)
            switch move
                case Move.Up
                    primeMove = Move.UpPrime;
                case Move.Down
                    primeMove = Move.DownPrime;
                case Move.Left
                    primeMove = Move.LeftPrime;
                case Move.Right
                    primeMove = Move.RightPrime;
                case Move.Front
                    primeMove = Move.FrontPrime;
                case Move.Back
                    primeMove = Move.BackPrime;
                case Move.Up2
                    primeMove = Move.UpPrime;
                case Move.Down2
                    primeMove = Move.DownPrime;
                case Move.Left2
                    primeMove = Move.LeftPrime;
                case Move.Right2
                    primeMove = Move.RightPrime;
                case Move.Front2
                    primeMove = Move.FrontPrime;
                case Move.Back2
                    primeMove = Move.BackPrime;
            end
        end

        function invertMove = getInvertMove(move)
            switch move
                case Move.Up
                    invertMove = Move.UpPrime;
                case Move.Down
                    invertMove = Move.DownPrime;
                case Move.Left
                    invertMove = Move.LeftPrime;
                case Move.Right
                    invertMove = Move.RightPrime;
                case Move.Front
                    invertMove = Move.FrontPrime;
                case Move.Back
                    invertMove = Move.BackPrime;
                case Move.UpPrime
                    invertMove = Move.Up;
                case Move.DownPrime
                    invertMove = Move.Down;
                case Move.LeftPrime
                    invertMove = Move.Left;
                case Move.RightPrime
                    invertMove = Move.Right;
                case Move.FrontPrime
                    invertMove = Move.Front;
                case Move.BackPrime
                    invertMove = Move.Back;
                otherwise
                    invertMove = move;
            end
        end
    end
end