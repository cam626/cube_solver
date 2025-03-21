function oneHotCubeStates = convertCubeStatesToOneHot(cubeStates)
    oneHotCubeStates = cell(size(cubeStates));

    for stateIdx = 1:numel(cubeStates)
        state = cubeStates{stateIdx};
        oneHotCubeStates{stateIdx} = dlarray(onehotencode(state(:), 2, 'ClassNames', enumeration('Color')), 'SC');
    end
end

