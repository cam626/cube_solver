function oneHotCubeStateSequences = convertCubeStateSequencesToOneHot(cubeStateSequences)
    oneHotCubeStateSequences = cell(size(cubeStateSequences));

    for sequenceIdx = 1:numel(cubeStateSequences)
        sequence = cubeStateSequences{sequenceIdx};
        oneHotCubeStateSequences{sequenceIdx} = dlarray(onehotencode(sequence(:, :), 3, 'ClassNames', enumeration('Color')), 'TSCB');
    end
end

