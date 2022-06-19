classdef NumUnsolvedCostModel
    methods (Static)
        function cost = getCost(cube)
            cost = 0;

            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});

                cost = cost + face.numIncorrect();
            end
        end
    end
end

