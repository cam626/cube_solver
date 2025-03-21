function cubeStateSequences = convertOneHotSequencesToCubeStates(oneHotStateSequences)
    cubeStateSequences = cell(size(oneHotStateSequences));

    for stateSequenceIdx = 1:numel(oneHotStateSequences)
        oneHotSequence = oneHotStateSequences{stateSequenceIdx};

        [~, squareColorSequence] = max(oneHotSequence, [], 2);
        seqSize = size(oneHotSequence);
        batchSize = seqSize(finddim(oneHotSequence, 'B'));
        cubeStateSequences{stateSequenceIdx} = reshape(squareColorSequence, 6, 3, 3, batchSize, []);
    end
end

