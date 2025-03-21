function [scrambles, cubeStateSequences] = generateScrambleDataset(minScrambleLen, maxScrambleLen, numScrambles, minInitialScrambleLen, maxInitialScrambleLen)
    % Each cube state is represented by it's 6 3x3 faces. The faces
    % appear in the order of the Color enumeration. A cube state 
    % sequence is L x 6 x 3 x 3, but L can differ between examples
    % so these are stored in cells.
    cubeStateSequences = cell(numScrambles, 1);

    % The scrambles might be different lengths, so we store them in cells.
    scrambles = cell(numScrambles, 1);

    % Allow each example to be processed in parallel
    parfor scrambleNum = 1:numScrambles
        c = Cube;
        scrambler = Scrambler;

        % Start with a random cube
        initialScrambleLen = randi(maxInitialScrambleLen - minInitialScrambleLen + 1) + minInitialScrambleLen - 1;
        initialScramble = scrambler.getScramble(initialScrambleLen);
        c.applyMoveList(initialScramble);

        % Get the example scramble
        exampleScrambleLen = randi(maxScrambleLen - minScrambleLen + 1) + minScrambleLen - 1;
        exampleScramble = scrambler.getScramble(exampleScrambleLen);

        % Apply the example scramble and record each state encountered
        sequence = zeros(exampleScrambleLen, 6, 3, 3);
        for moveNum = 1:numel(exampleScramble)
            move = exampleScramble(moveNum);
            c.rotate(move);
            sequence(moveNum, :, :, :) = c.toRawFaces();
        end

        % Record the results for this iteration/worker
        cubeStateSequences{scrambleNum} = sequence;
        scrambles{scrambleNum} = exampleScramble;
    end
end