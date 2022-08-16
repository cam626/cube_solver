function [originalCubes,moves,transformedCubes] = generateRandomCubeMovementDataInParallel(numWorkers, cubesPerWorker)
    MOVES_PER_SCRAMBLE = 15;
    NUM_CUBES = numWorkers * cubesPerWorker;
    
    % Tell the workers to create a chunk of cubes/moves/resulting cubes and store futures for the
    % outputs
    workerOutputs = {};
    for workerNum = 1:numWorkers
        workerOutputs{workerNum} = parfeval(@generateRandomCubeMovementData, 3, cubesPerWorker, MOVES_PER_SCRAMBLE); %#ok
    end
    
    % Allocate space for all data
    originalCubes = zeros(NUM_CUBES, 6, 6, 3, 3);
    moves = zeros(NUM_CUBES, 1);
    transformedCubes = zeros(NUM_CUBES, 6, 6, 3, 3);
    
    % Copy the cubes and moves from each worker into the larger dataset
    for workerNum = 1:numWorkers
        [origCubes, someMoves, transformedCubes] = fetchOutputs(workerOutputs{workerNum});
    
        blockStart = (workerNum-1)*cubesPerWorker+1;
        blockEnd = workerNum*cubesPerWorker;
    
        originalCubes(blockStart:blockEnd, :, :, :, :) = origCubes;
        moves(blockStart:blockEnd) = someMoves;
        transformedCubes(blockStart:blockEnd, :, :, :, :) = transformedCubes;
    end
end