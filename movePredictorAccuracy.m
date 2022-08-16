function accuracy = movePredictorAccuracy(net, inputData, transformedCubes)
    predictions = predict(net, inputData);

    predictedColors = round(predictions);

    accuracy = sum(predictedColors == transformedCubes, 'all') / numel(transformedCubes);
end