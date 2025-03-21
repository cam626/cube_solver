classdef Scrambler < handle
    properties
        moves = enumeration('Move');
        moveList;
        numMoves;
        nextMoveNum = 1;
        inSamePlane;
    end

    methods
        function moveList = scramble(scrambler, cube, numMoves)
            moveList = scrambler.getScramble(numMoves);

            cube.applyMoveList(moveList);
        end

        function moveList = getScramble(scrambler, numMoves)
            scrambler.initialize(numMoves);
            scrambler.createScramble();
            
            moveList = scrambler.moveList;
        end
    end

    methods (Access=private)

        function initialize(scrambler, numMoves)
            scrambler.nextMoveNum = 1;
            scrambler.numMoves = numMoves;

            % Allocate space for all moves in the scramble
            scrambler.moveList = zeros(1, numMoves);

            scrambler.inSamePlane = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

            scrambler.inSamePlane(Move.Up.toInt()) = [Move.DownPrime, Move.UpPrime, Move.Up2, Move.Down, Move.Down2];
            scrambler.inSamePlane(Move.Up2.toInt()) = [Move.DownPrime, Move.UpPrime, Move.Up, Move.Down, Move.Down2];
            scrambler.inSamePlane(Move.UpPrime.toInt()) = [Move.DownPrime, Move.Up2, Move.Up, Move.Down, Move.Down2];
            scrambler.inSamePlane(Move.Down.toInt()) = [Move.DownPrime, Move.UpPrime, Move.Up2, Move.Up, Move.Down2];
            scrambler.inSamePlane(Move.Down2.toInt()) = [Move.DownPrime, Move.UpPrime, Move.Up2, Move.Up, Move.Down];
            scrambler.inSamePlane(Move.DownPrime.toInt()) = [Move.Down2, Move.UpPrime, Move.Up2, Move.Up, Move.Down];
            scrambler.inSamePlane(Move.Left.toInt()) = [Move.LeftPrime, Move.RightPrime, Move.Left2, Move.Right, Move.Right2];
            scrambler.inSamePlane(Move.Left2.toInt()) = [Move.LeftPrime, Move.RightPrime, Move.Left, Move.Right, Move.Right2];
            scrambler.inSamePlane(Move.LeftPrime.toInt()) = [Move.Left2, Move.RightPrime, Move.Left, Move.Right, Move.Right2];
            scrambler.inSamePlane(Move.Right.toInt()) = [Move.LeftPrime, Move.RightPrime, Move.Right2, Move.Left, Move.Left2];
            scrambler.inSamePlane(Move.Right2.toInt()) = [Move.LeftPrime, Move.RightPrime, Move.Right, Move.Left, Move.Left2];
            scrambler.inSamePlane(Move.RightPrime.toInt()) = [Move.LeftPrime, Move.Right2, Move.Right, Move.Left, Move.Left2];
            scrambler.inSamePlane(Move.Front.toInt()) = [Move.FrontPrime, Move.BackPrime, Move.Front2, Move.Back, Move.Back2];
            scrambler.inSamePlane(Move.Front2.toInt()) = [Move.FrontPrime, Move.BackPrime, Move.Front, Move.Back, Move.Back2];
            scrambler.inSamePlane(Move.FrontPrime.toInt()) = [Move.Front2, Move.BackPrime, Move.Front, Move.Back, Move.Back2];
            scrambler.inSamePlane(Move.Back.toInt()) = [Move.FrontPrime, Move.BackPrime, Move.Back2, Move.Front, Move.Front2];
            scrambler.inSamePlane(Move.Back2.toInt()) = [Move.FrontPrime, Move.BackPrime, Move.Back, Move.Front, Move.Front2];
            scrambler.inSamePlane(Move.BackPrime.toInt()) = [Move.FrontPrime, Move.Back2, Move.Back, Move.Front, Move.Front2];
        end

        function createScramble(scrambler)
            for moveNum = 1:scrambler.numMoves
                scrambler.addMoveToScramble()
            end
        end

        function addMoveToScramble(scrambler)
            newMove = scrambler.chooseNextMove();

            scrambler.moveList(scrambler.nextMoveNum) = newMove;
            scrambler.nextMoveNum = scrambler.nextMoveNum + 1;
        end

        function movePair = chooseNextMove(scrambler)
            possibleMoves = scrambler.determinePossibleMoves();

            movePair = scrambler.chooseRandomMove(possibleMoves);
        end

        function possibleMoves = determinePossibleMoves(scrambler)
            possibleMoves = scrambler.disallowRepeatedMoves(scrambler.moves);
        end

        function possibleMoves = disallowRepeatedMoves(scrambler, possibleMoves)
            if scrambler.nextMoveNum > 1
                lastMove = Move(scrambler.getLastMove());
                sameFaceMoves = lastMove.getSameFaceMoves();

                possibleMoves = setdiff(possibleMoves, [lastMove, sameFaceMoves]);
            end
        end

        function possibleMoves = disallowTripleRepeatedPlanes(scrambler, possibleMoves)
            if scrambler.nextMoveNum < 3
                return;
            end

            lastMovePair = scrambler.getLastMove();
            secondLastMovePair = scrambler.getSecondLastMove();

            samePlaneAsLastMove = scrambler.inSamePlane(lastMovePair{1});

            if ismember(secondLastMovePair{1}, samePlaneAsLastMove)
                possibleMoves = setdiff(possibleMoves, samePlaneAsLastMove);
            end
        end

        function lastMove = getLastMove(scrambler)
            lastMove = scrambler.moveList(scrambler.nextMoveNum-1);
        end

        function lastMove = getSecondLastMove(scrambler)
            lastMove = scrambler.moveList(scrambler.nextMoveNum-2);
        end
    end

    methods (Static)

        function newMove = chooseRandomMove(possibleMoves)
            newMove = randsample(possibleMoves, 1);
        end

    end
end

