classdef Cube < handle
    properties
        faces
        ax3d
    end

    methods
        function cube = Cube()
            cube.createFaces()

            % Attaches the patchLocations to the cube's faces
            generator = CubePatchGenerator;
            generator.createPatches(cube, 1);
        end

        function rotate(cube, move)
            cube.rotateSwitch(move)

            if ~isempty(cube.ax3d)
                cube.show();
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
            if isempty(cube.ax3d)
                cube.ax3d = Cube.createCubeAxes();
            end

            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});
                face.show(cube.ax3d);
            end
        end

        function flat = flatten(cube)
            flat = zeros(54,1);

            ind = 1;
            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});
                flat((ind-1)*9+1:ind*9) = face.flatten();
                ind = ind + 1;
            end
        end

        function masks = generateMasks(cube)
            masks = zeros(6,6,3,3);

            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});
                
                masks(face.baseColor.toInt(),:,:,:) = face.generateMasks();
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



