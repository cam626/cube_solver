classdef Cube < handle
    properties
        faces
    end

    methods
        function cube = Cube()
            cube.createFaces()

            % Attaches the patchLocations to the cube's faces
            generator = CubePatchGenerator;
            generator.createPatches(cube, 1);
        end

        function rotate(cube, move, primeFlag)
            if move.is2Move()
                cube.rotate2Move(move);
            elseif primeFlag
                cube.rotateCounterClockwise(move);
            else
                cube.rotateClockwise(move);
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

        function show(cube)
            ax = Cube.createCubeAxes();

            for faceColor = keys(cube.faces)
                face = cube.faces(faceColor{1});
                face.show(ax)
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

        function rotateCounterClockwise(cube, move)
            switch move
                case Move.Up
                    cube.rotateUPrime();
                case Move.Down
                    cube.rotateDPrime();
                case Move.Left
                    cube.rotateLPrime();
                case Move.Right
                    cube.rotateRPrime();
                case Move.Front
                    cube.rotateFPrime();
                case Move.Back
                    cube.rotateBPrime();
            end
        end

        function rotateClockwise(cube, move)
            switch move
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
            end
        end

        function rotate2Move(cube, move)
            switch move
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



