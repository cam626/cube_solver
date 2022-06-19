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

        function createFaces(cube)
            factory = FaceFactory;
            cube.faces = factory.getFaces();
        end

        function rotate(cube, move)
            switch move
                case Move.Up
                    cube.rotateU();
                case Move.UpPrime
                    cube.rotateUPrime();
                case Move.Down
                    cube.rotateD();
                case Move.DownPrime
                    cube.rotateDPrime();
                case Move.Left
                    cube.rotateL();
                case Move.LeftPrime
                    cube.rotateLPrime();
                case Move.Right
                    cube.rotateR();
                case Move.RightPrime
                    cube.rotateRPrime();
                case Move.Front
                    cube.rotateF();
                case Move.FrontPrime
                    cube.rotateFPrime();
                case Move.Back
                    cube.rotateB();
                case Move.BackPrime
                    cube.rotateBPrime();
            end
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
        function rotateU(cube)
            f = cube.faces(Color.White.toInt());
            f.rotateClockwise();
        end

        function rotateUPrime(cube)
            f = cube.faces(Color.White.toInt());
            f.rotateCounterClockwise();
        end

        function rotateD(cube)
            f = cube.faces(Color.Yellow.toInt());
            f.rotateClockwise();
        end

        function rotateDPrime(cube)
            f = cube.faces(Color.Yellow.toInt());
            f.rotateCounterClockwise();
        end

        function rotateL(cube)
            f = cube.faces(Color.Orange.toInt());
            f.rotateClockwise();
        end

        function rotateLPrime(cube)
            f = cube.faces(Color.Orange.toInt());
            f.rotateCounterClockwise();
        end

        function rotateR(cube)
            f = cube.faces(Color.Red.toInt());
            f.rotateClockwise();
        end

        function rotateRPrime(cube)
            f = cube.faces(Color.Red.toInt());
            f.rotateCounterClockwise();
        end

        function rotateF(cube)
            f = cube.faces(Color.Green.toInt());
            f.rotateClockwise();
        end

        function rotateFPrime(cube)
            f = cube.faces(Color.Green.toInt()).rotateCounterClockwise();
            f.rotateCounterClockwise();
        end

        function rotateB(cube)
            f = cube.faces(Color.Blue.toInt());
            f.rotateClockwise();
        end

        function rotateBPrime(cube)
            f = cube.faces(Color.Blue.toInt());
            f.rotateCounterClockwise();
        end
    end
end



