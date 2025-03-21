function cubeStateSequences = stripInitialCubeState(cubeStateSequences)
    for seqIdx = 1:numel(cubeStateSequences)
        sequence = cubeStateSequences{seqIdx};
        cubeStateSequences{seqIdx} = sequence(2:end, :, :, :);
    end
end

