function accuracy = moveAccuracy(predictedCubeColors, actualCubeColors)
    [~, predictedCubeColors] = max(predictedCubeColors, [], 2);
    [~, actualCubeColors] = max(actualCubeColors, [], 2);

    accuracy = sum(sum(predictedCubeColors == actualCubeColors, 1) == 54, 'all') / size(actualCubeColors, 3) * 100;
end

