classdef NumSolvedCostModel
    methods (Static)
        function cost = getCost(cube)
            cost = 0;

            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});

                % Having only 1-3 correct doesn't give reward (center is
                % always correct)
                tilesGivingReward = max(face.numCorrect() - 3, 0);

                % Quadratic so that having more tiles on a single face is
                % more rewarding that having a few correct tiles on each
                % face
                cost = cost + (tilesGivingReward ^ 2) / 6;
                
                % Strong bonus for solving the whole face
                if face.isSolved()
                    cost = cost + 10;
                end
            end

            % Penalize the agent for living to encourage it to try to get
            % points
            cost = cost - 1;
        end
    end
end

