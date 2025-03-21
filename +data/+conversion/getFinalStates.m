function finalCubeStates = getFinalStates(cubeStateSequences)
    finalCubeStates = cell(size(cubeStateSequences));

    for sequenceIdx = 1:numel(cubeStateSequences)
        sequence = cubeStateSequences{sequenceIdx};
        finalCubeStates{sequenceIdx} = sequence(end, :, :, :);
    end
end

