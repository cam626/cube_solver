classdef CubePatchGenerator
    properties
        offsetColors = [Color.White Color.Blue Color.Red];
        colorPlaneMap
    end

    methods
        function generator = CubePatchGenerator()
            generator.colorPlaneMap = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
            
            generator.colorPlaneMap(Color.White.toInt()) = Plane.XY;
            generator.colorPlaneMap(Color.Green.toInt()) = Plane.XZ;
            generator.colorPlaneMap(Color.Yellow.toInt()) = Plane.XY;
            generator.colorPlaneMap(Color.Blue.toInt()) = Plane.XZ;
            generator.colorPlaneMap(Color.Orange.toInt()) = Plane.YZ;
            generator.colorPlaneMap(Color.Red.toInt()) = Plane.YZ; 
        end

        function createPatches(generator, cube, scale)
            for faceColor = keys(cube.faces)
                generator.setPatchesForFace(cube.faces(faceColor{1}), scale);
            end
        end

        function setPatchesForFace(generator, face, scale)
            patches = generator.createPatchesForColor(face.baseColor, scale);
            face.patchLocations = patches;
        end

        function patches = createPatchesForColor(generator, color, scale)
            patches = cell(3);

            for tileX = 1:3
                pos1 = (tileX-1) / 3 * scale;

                for tileY = 1:3
                    pos2 = (tileY-1) / 3 * scale;

                    rowInd = tileY;
                    if color == Color.Orange || color == Color.Green || color == Color.Red || color == Color.White
                        rowInd = 4 - rowInd;
                    end

                    colInd = tileX;
                    if color == Color.Orange
                        colInd = 4 - colInd;
                    end

                    patches{rowInd, colInd} = generator.createTileInPlane(generator.colorPlaneMap(color.toInt()), pos1, pos2, color, scale);
                end
            end
        end

        function tile = createTileInPlane(generator, plane, pos1, pos2, color, scale)
            offset = ismember(color, generator.offsetColors) * scale;

            switch plane
                case Plane.XY
                    tile = generator.createTileInXYPlane(pos1, pos2, offset, scale / 3, scale / 3);
                case Plane.YZ
                    tile = generator.createTileInYZPlane(pos1, pos2, offset, scale / 3, scale / 3);
                case Plane.XZ
                    tile = generator.createTileInXZPlane(pos1, pos2, offset, scale / 3, scale / 3);
            end
        end
    end

    methods (Static)
        function tile = createTileInXYPlane(xPos, yPos, zOffset, width, height)
            tile = [[xPos, yPos, zOffset];
                    [xPos+width, yPos, zOffset];
                    [xPos+width, yPos+height, zOffset];
                    [xPos, yPos+height, zOffset]];
        end

        function tile = createTileInYZPlane(yPos, zPos, xOffset, width, height)
            tile = [[xOffset, yPos, zPos];
                    [xOffset, yPos+width, zPos];
                    [xOffset, yPos+width, zPos+height];
                    [xOffset, yPos, zPos+height]];
        end

        function tile = createTileInXZPlane(xPos, zPos, yOffset, width, height)
            tile = [[xPos, yOffset, zPos];
                    [xPos+width, yOffset, zPos];
                    [xPos+width, yOffset, zPos+height];
                    [xPos, yOffset, zPos+height]];
        end
    end

end

