function [inputs, labels] = createMoveDataset(moveArray, startingCubeStates, endingCubeStates)
    oneHotMoves = onehotencode(moveArray, 2, 'ClassNames', enumeration('Move'));
    flattenedOneHotStartStates = onehotencode(startingCubeStates(:, :), 3, 'ClassNames', enumeration('Color'));
    flattenedOneHotEndStates = onehotencode(endingCubeStates(:, :), 3, 'ClassNames', enumeration('Color'));
    flattenedOneHotStartStates = flattenedOneHotStartStates(:, :);
    flattenedOneHotEndStates = flattenedOneHotEndStates(:, :, :);
    
    inputs = dlarray([flattenedOneHotStartStates, oneHotMoves], 'BC');
    labels = dlarray(flattenedOneHotEndStates, 'BSC');
end

