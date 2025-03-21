classdef Cube < handle
    properties
        faces
        ax3d
    end

    methods
        function cube = Cube()
            cube.createFaces()
        end

        function rotate(cube, move)
            cube.rotateSwitch(move)

            if ~isempty(cube.ax3d)
                cube.show();
            end
        end
        
        function applyMoveList(cube, moveList)
            for moveNum = 1:numel(moveList)
                cube.rotate(moveList(moveNum));
            end
        end

        function setStateFromPrediction(cube, predictedState)
            [~, colors] = max(predictedState, [], 2);

            rawFaces = reshape(colors, 6, 3, 3);
            cube.setStateFromRawFaces(rawFaces);
        end

        function setStateFromRawFaces(cube, rawFaces)
            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});

                face.setGrid(squeeze(rawFaces(faceColor{1}, :, :)));
            end
        end
        
        function solved = isSolved(cube)
            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});

                % The cube is not solved if any face is not solved
                if ~face.isSolved
                    solved = false;
                    return;
                end
            end

            solved = true;
        end

        function reset(cube)
            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});

                face.reset();
            end

            if ~isempty(cube.ax3d)
                cube.show();
            end
        end

        function show(cube)
            if ~cube.faces(1).hasPatchLocations()
                % Attaches the patchLocations to the cube's faces so that we
                % know where to render them.
                generator = CubePatchGenerator;
                generator.createPatches(cube, 1);
            end

            if isempty(cube.ax3d)
                cube.ax3d = Cube.createCubeAxes();
            end

            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});
                face.show(cube.ax3d);
            end
        end

        function show2d(cube)
            facesListArray = cube.generateFacesListArray();
            pcolor(facesListArray');

            cmap = [0 0 0; 1 1 1; 0 1 0; 1 1 0; 0 0 1; 1 0 0; 1 0.647 0];
            colormap(cmap);
        end

        function show2dComparison(cube, otherCube)
            facesListArray = cube.generateFacesListArray();
            otherFacesListArray = otherCube.generateFacesListArray();
            solvedCube = Cube;
            solvedCubeFacesListArray = solvedCube.generateFacesListArray();

            % Put the cube face list arrays all into one large array with a
            % bit of visual separation between them
            comparisonArray = zeros(3*3 + 2 + 1, 6*3 + 1);
            comparisonArray(1:3, 1:end) = facesListArray(1:end, 1:3)';
            comparisonArray(5:7, 1:end) = otherFacesListArray(1:end, 1:3)';
            comparisonArray(9:11, 1:end) = solvedCubeFacesListArray(1:end, 1:3)';

            pcolor(comparisonArray);

            cmap = [0 0 0; 1 1 1; 0 1 0; 1 1 0; 0 0 1; 1 0 0; 1 0.647 0];
            colormap(cmap);
        end

        function facesListArray = generateFacesListArray(cube)
            facesListArray = zeros(3*6+1, 3+1);
            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});

                faceStart = (faceColor{1} - 1) * 3 + 1;
                facesListArray(faceStart:faceStart+2, 1:3) = face.getGrid();
            end
        end

        function flat = flatten(cube)
            % Flattens the cube to a vector of Colors
            flat = zeros(54,1);

            ind = 1;
            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});
                flat((ind-1)*9+1:ind*9) = face.flatten();
                ind = ind + 1;
            end
        end

        function masks = generateMasks(cube)
            % Generates one-hot encoded color masks for each face of the
            % cube
            masks = zeros(6,6,3,3);

            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});
                
                masks(face.baseColor.toInt(),:,:,:) = face.generateMasks();
            end
        end

        function rawFaces = toRawFaces(cube)
            % Collects the Colors of each face in the cube
            rawFaces = zeros(6, 3, 3);

            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});
                
                rawFaces(faceColor{1}, :, :) = face.getGrid();
            end
        end
    end

    methods (Static)
        function ax = createCubeAxes()
            ax = axes();

            xlim(ax, [0 4]);
            ylim(ax, [0 4]);
            zlim(ax, [0 4]);
        end
    end

    methods (Access=private)

        function createFaces(cube)
            factory = FaceFactory;
            cube.faces = factory.getFaces();
        end

        function rotateSwitch(cube, move)
            switch move
                case Move.UpPrime
                    cube.rotateUPrime();
                case Move.DownPrime
                    cube.rotateDPrime();
                case Move.LeftPrime
                    cube.rotateLPrime();
                case Move.RightPrime
                    cube.rotateRPrime();
                case Move.FrontPrime
                    cube.rotateFPrime();
                case Move.BackPrime
                    cube.rotateBPrime();
                case Move.Up
                    cube.rotateU();
                case Move.Down
                    cube.rotateD();
                case Move.Left
                    cube.rotateL();
                case Move.Right
                    cube.rotateR();
                case Move.Front
                    cube.rotateF();
                case Move.Back
                    cube.rotateB();
                case Move.Up2
                    cube.rotateU2();
                case Move.Down2
                    cube.rotateD2();
                case Move.Left2
                    cube.rotateL2();
                case Move.Right2
                    cube.rotateR2();
                case Move.Front2
                    cube.rotateF2();
                case Move.Back2
                    cube.rotateB2();
            end
        end

        function rotateU(cube)
            f = cube.faces(Color.White.toInt());
            f.rotateClockwise();
        end

        function rotateUPrime(cube)
            f = cube.faces(Color.White.toInt());
            f.rotateCounterClockwise();
        end

        function rotateU2(cube)
            f = cube.faces(Color.White.toInt());
            f.rotateClockwise();
            f.rotateClockwise();
        end

        function rotateD(cube)
            f = cube.faces(Color.Yellow.toInt());
            f.rotateClockwise();
        end

        function rotateDPrime(cube)
            f = cube.faces(Color.Yellow.toInt());
            f.rotateCounterClockwise();
        end

        function rotateD2(cube)
            f = cube.faces(Color.Yellow.toInt());
            f.rotateClockwise();
            f.rotateClockwise();
        end

        function rotateL(cube)
            f = cube.faces(Color.Orange.toInt());
            f.rotateClockwise();
        end

        function rotateLPrime(cube)
            f = cube.faces(Color.Orange.toInt());
            f.rotateCounterClockwise();
        end

        function rotateL2(cube)
            f = cube.faces(Color.Orange.toInt());
            f.rotateClockwise();
            f.rotateClockwise();
        end

        function rotateR(cube)
            f = cube.faces(Color.Red.toInt());
            f.rotateClockwise();
        end

        function rotateRPrime(cube)
            f = cube.faces(Color.Red.toInt());
            f.rotateCounterClockwise();
        end

        function rotateR2(cube)
            f = cube.faces(Color.Red.toInt());
            f.rotateClockwise();
            f.rotateClockwise();
        end

        function rotateF(cube)
            f = cube.faces(Color.Green.toInt());
            f.rotateClockwise();
        end

        function rotateFPrime(cube)
            f = cube.faces(Color.Green.toInt());
            f.rotateCounterClockwise();
        end

        function rotateF2(cube)
            f = cube.faces(Color.Green.toInt());
            f.rotateClockwise();
            f.rotateClockwise();
        end

        function rotateB(cube)
            f = cube.faces(Color.Blue.toInt());
            f.rotateClockwise();
        end

        function rotateBPrime(cube)
            f = cube.faces(Color.Blue.toInt());
            f.rotateCounterClockwise();
        end

        function rotateB2(cube)
            f = cube.faces(Color.Blue.toInt());
            f.rotateClockwise();
            f.rotateClockwise();
        end
    end
end



