function accuracy = cubeFaceAccuracy(predictedCubeColors, actualCubeColors)
    [~, predictedCubeColors] = max(predictedCubeColors, [], 2);
    [~, actualCubeColors] = max(actualCubeColors, [], 2);

    accuracy = sum(predictedCubeColors == actualCubeColors, 'all') / numel(actualCubeColors) * 100;
end

