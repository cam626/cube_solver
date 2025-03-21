function [moveArray, startingCubeStates, endingCubeStates] = generateMoveDataset(numExamples, minInitialScrambleLen, maxInitialScrambleLen)
    % Each cube state is represented by it's 6 3x3 faces. The faces
    % appear in the order of the Color enumeration.
    startingCubeStates = zeros(numExamples, 6, 3, 3);
    endingCubeStates = zeros(numExamples, 6, 3, 3);

    moveArray = zeros(numExamples, 1);

    % Allow each example to be processed in parallel
    parfor exampleNum = 1:numExamples
        c = Cube;
        scrambler = Scrambler;

        % Start with a random cube
        initialScrambleLen = randi(maxInitialScrambleLen - minInitialScrambleLen + 1) + minInitialScrambleLen - 1;
        initialScramble = scrambler.getScramble(initialScrambleLen);
        c.applyMoveList(initialScramble);
        startingCubeStates(exampleNum, :, :, :) = c.toRawFaces();

        % Get the example scramble
        exampleMove = scrambler.getScramble(1);
        moveArray(exampleNum) = exampleMove;

        c.rotate(exampleMove);
        endingCubeStates(exampleNum, :, :, :) = c.toRawFaces();
    end
end