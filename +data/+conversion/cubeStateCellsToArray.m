function cubeStatesArray = cubeStateCellsToArray(cubeStates)
    cubeStatesArray = dlarray(zeros(numel(cubeStates), 54, 6), 'BSC');

    for cubeStateIdx = 1:numel(cubeStates)
        cubeStatesArray(:, :, cubeStateIdx) = cubeStates{cubeStateIdx};
    end
end

