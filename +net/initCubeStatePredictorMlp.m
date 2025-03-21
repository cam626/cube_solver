function net = initCubeStatePredictorMlp(config)
    layers = [
        % One-hot encoded colors for each square and a one-hot encoded move
        featureInputLayer(6*3*3*6 + numel(enumeration('Move')))
    ];

    for layerNum = 1:config.numLayers
        layers = [
            layers
            fullyConnectedLayer(config.layerWidth)
            reluLayer()
        ]; %#ok
    end

    layers = [
        layers
        fullyConnectedLayer(6*6*3*3)
        functionLayer(@reshapeLayer, 'Formattable', true)
        softmaxLayer
    ];

    exampleCubeAndMove = dlarray(zeros([6*3*3*6 + numel(enumeration('Move')) 2]), 'CB');
    net = dlnetwork(layers, exampleCubeAndMove);
end

function reshapedOutput = reshapeLayer(input)
    s = size(input);
    batchSize = s(finddim(input, 'B'));
    reshapedOutput = dlarray(reshape(input, 6, 54, batchSize), 'CSB');
end