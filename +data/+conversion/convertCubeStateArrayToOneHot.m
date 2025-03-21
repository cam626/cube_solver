function oneHotCubeStateArray = convertCubeStateArrayToOneHot(cubeStateArray)
     oneHotCubeStateArray = dlarray(onehotencode(cubeStateArray(:, :), 3, 'ClassNames', enumeration('Color')), 'BSC');
end

