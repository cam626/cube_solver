classdef CubeOutputLayer < nnet.layer.RegressionLayer & nnet.layer.Acceleratable
    methods
        function loss = forwardLoss(~, predictions, labels)
            loss = sum(uint32(predictions ~= labels), "all");
        end
    end
end