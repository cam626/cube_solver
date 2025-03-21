function [trainInputs, trainLabels, validInputs, validLabels] = splitMoveDataset(inputs, labels, trainSplitPercentage)
    shuffledIndices = randperm(size(inputs, 2));
    numTrain = int32(size(inputs, 2) * trainSplitPercentage);
    trainIndices = shuffledIndices(1:numTrain);
    validIndices = shuffledIndices(numTrain+1:end);

    trainInputs = inputs(:, trainIndices);
    trainLabels = labels(:, :, trainIndices);
    validInputs = inputs(:, validIndices);
    validLabels = labels(:, :, validIndices);
end

