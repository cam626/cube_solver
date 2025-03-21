load('C:\Users\camsc\Documents\projects\cube_solver\data_files\scramble_dataset_1_to_15_init_15_1000000.mat', ...
    'finalCubeStateArray', 'scrambles');

oneHotFinalCubeStates = data.conversion.convertCubeStateArrayToOneHot(finalCubeStateArray);
encodedScrambles = data.conversion.convertMovesToOneHot(scrambles);

network = net.initCubeStatePredictorLstm(150);
opts = trainingOptions('adam', 'Plots', 'training-progress', 'InitialLearnRate', 0.001, 'MiniBatchSize', 1024, 'MaxEpochs', 100);
opts.TargetDataFormats = 'SBC';
trainnet(encodedScrambles, oneHotFinalCubeStateArray, network, 'binary-crossentropy', opts);
