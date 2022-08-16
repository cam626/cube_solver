function [trainingCubes, trainingMoves, trainingCubesTransformed] = generateTrainingData(numSamples)
    [trainingCubes, trainingMoves, trainingCubesTransformed] = generateRandomCubeMovementDataInParallel(8, numSamples/8);
end