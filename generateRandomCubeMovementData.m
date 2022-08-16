function [originalCubes, chosenMoves, transformedCubes] = generateRandomCubeMovementData(numCubes, movesPerScramble)
    scrambler = Scrambler;
    cube = Cube;
    moves = enumeration('Move').toInt();

    originalCubes = zeros(numCubes, 6, 6, 3, 3);
    chosenMoves = zeros(numCubes, 1);
    transformedCubes = zeros(numCubes, 6, 6, 3, 3);

    for cubeNum = 1:numCubes
        cube.reset();

        % TODO: Make number of moves optionally random
        scrambler.scramble(cube, movesPerScramble);

        originalCubes(cubeNum, :, :, :, :) = cube.generateMasks();
        
        chosenMoves(cubeNum) = randsample(moves, 1);
        cube.rotate(Move(chosenMoves(cubeNum)));
        
        transformedCubes(cubeNum, :, :, :, :) = cube.generateMasks();
    end
end