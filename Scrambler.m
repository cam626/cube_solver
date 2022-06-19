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

            Utils.applyMoveList(cube, moveList);
        end

        function moveList = getScramble(scrambler, numMoves)
            scrambler.initialize(numMoves);
            scrambler.createScramble();
            
            moveList = scrambler.moveList;
        end
    end

    methods (Access=private)

        function initialize(scrambler, numMoves)
            scrambler.numMoves = numMoves;

            % Allocate space for all moves in the scramble
            scrambler.moveList = cell(numMoves, 2);

            scrambler.inSamePlane = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

            scrambler.inSamePlane(Move.Up.toInt()) = [Move.Up2, Move.Down, Move.Down2];
            scrambler.inSamePlane(Move.Up2.toInt()) = [Move.Up, Move.Down, Move.Down2];
            scrambler.inSamePlane(Move.Down.toInt()) = [Move.Up2, Move.Up, Move.Down2];
            scrambler.inSamePlane(Move.Down2.toInt()) = [Move.Up2, Move.Up, Move.Down];
            scrambler.inSamePlane(Move.Left.toInt()) = [Move.Left2, Move.Right, Move.Right2];
            scrambler.inSamePlane(Move.Left2.toInt()) = [Move.Left, Move.Right, Move.Right2];
            scrambler.inSamePlane(Move.Right.toInt()) = [Move.Right2, Move.Left, Move.Left2];
            scrambler.inSamePlane(Move.Right2.toInt()) = [Move.Right, Move.Left, Move.Left2];
            scrambler.inSamePlane(Move.Front.toInt()) = [Move.Front2, Move.Back, Move.Back2];
            scrambler.inSamePlane(Move.Front2.toInt()) = [Move.Front, Move.Back, Move.Back2];
            scrambler.inSamePlane(Move.Back.toInt()) = [Move.Back2, Move.Front, Move.Front2];
            scrambler.inSamePlane(Move.Back2.toInt()) = [Move.Back, Move.Front, Move.Front2];
        end

        function createScramble(scrambler)
            for moveNum = 1:scrambler.numMoves
                scrambler.addMoveToScramble()
            end
        end

        function addMoveToScramble(scrambler)
            newMovePair = scrambler.chooseNextMove();

            scrambler.moveList{scrambler.nextMoveNum, 1} = newMovePair{1};
            scrambler.moveList{scrambler.nextMoveNum, 2} = newMovePair{2};
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
                lastMovePair = scrambler.getLastMove();
                lastMove = lastMovePair{1};
                altLastMove = lastMove.getAltMove();

                possibleMoves = setdiff(possibleMoves, [lastMove, altLastMove]);
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

        function lastMovePair = getLastMove(scrambler)
            lastMovePair{1} = scrambler.moveList{scrambler.nextMoveNum-1, 1};
            lastMovePair{2} = scrambler.moveList{scrambler.nextMoveNum-1, 2};
        end

        function lastMovePair = getSecondLastMove(scrambler)
            lastMovePair{1} = scrambler.moveList{scrambler.nextMoveNum-2, 1};
            lastMovePair{2} = scrambler.moveList{scrambler.nextMoveNum-2, 2};
        end
    end

    methods (Static)

        function movePair = chooseRandomMove(possibleMoves)
            newMove = randsample(possibleMoves, 1);
            primeFlag = logical(randi(2) - 1);

            movePair = {newMove, primeFlag};
        end

    end
end

