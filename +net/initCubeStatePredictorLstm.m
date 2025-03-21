function net = initCubeStatePredictorLstm(config)
    layers = [
        % sequenceInputLayer(numel(enumeration('Move')))
        sequenceInputLayer(1)
        wordEmbeddingLayer(config.wordEmbeddingDim, numel(enumeration('Move')))
    ];


    for layerNum = 1:config.numLayersPreLstm
        layers = [
            layers
            fullyConnectedLayer(config.preLstmLayerWidth)
            reluLayer()
        ]; %#ok
    end

    layers = [
        layers
        lstmLayer(config.lstmWidth, "OutputMode", "sequence")
    ];

    for layerNum = 1:config.numLayersPostLstm
        layers = [
            layers
            fullyConnectedLayer(config.postLstmLayerWidth)
            reluLayer()
        ]; %#ok
    end

    layers = [
        layers
        fullyConnectedLayer(6*6*3*3)
        functionLayer(@reshapeLayer, 'Formattable', true)
        softmaxLayer
    ];

    % exampleSeq = dlarray(zeros([numel(enumeration('Move')) 2 5]), 'CBT');
    exampleSeq = dlarray(zeros([1 2 5]), 'CBT');
    net = dlnetwork(layers, exampleSeq);
end

function reshapedOutput = reshapeLayer(input)
    s = size(input);
    batchSize = s(finddim(input, 'B'));
    reshapedOutput = dlarray(reshape(input, 6, 54, batchSize, []), 'CSBT');
end