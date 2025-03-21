function resultStateArray = convertSingleMoveCubeStateSequencesToResultStateArray(cubeStateSequences)
    resultStateArray = zeros(numel(cubeStateSequences), 6*3*3);

    for i = 1:numel(cubeStateSequences)
        resultStateArray(i, :) = squeeze(cubeStateSequences{i}(:));
    end
    resultStateArray = dlarray(onehotencode(resultStateArray, 3, 'ClassNames', enumeration('Color')), 'BSC');
end

