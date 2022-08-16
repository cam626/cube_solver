function datastore = createDatastore()
    load('trainingData_masks.mat', 'trainingCubes', 'trainingMoves', 'trainingCubesTransformed');

    trainingMoves(:,1,1,1,1) = trainingMoves(:,1);

    cubes = arrayDatastore(trainingCubes);
    moves = arrayDatastore(trainingMoves);
    transformedCubes = arrayDatastore(categorical(trainingCubesTransformed));

    disp(size(trainingCubes));
    disp(size(trainingMoves));
    disp(size(trainingCubesTransformed));

    cubes.OutputType = "cell";
    moves.OutputType = "cell";
    transformedCubes.OutputType = "cell";

    datastore = combine(cubes, moves, transformedCubes);
end