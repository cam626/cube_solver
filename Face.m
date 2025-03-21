classdef Face < handle
    properties
        % 3x3 Matrix of Color
        grid

        % The Color that grid is initialized with. The center square of
        % grid will always remain this Color. (This assumes no center moves
        % are done)
        baseColor

        % A Map to the Faces in each direction relative to standard 
        % orientation. This is set by the FaceFactory on creation.
        connectionsMap

        % All of the patches coordinates needed to render this Face
        % (9 patches). This is set by the FaceFactory on creation.
        patchLocations

        % Handles to the patches that were created to render this Face.
        patches
    end
    
    methods
        function face = Face(originalColor)
            face.baseColor = originalColor;

            face.initializeGrid();
        end

        function color = colorAt(face, row, col)
            color = Color(face.grid(row, col));
        end

        function rotateClockwise(face)
            face.rotateGridClockwise();
            
            clockwiseDirections = [Direction.Top Direction.Right Direction.Bottom Direction.Left];
            flips = face.getFlipsForColor();

            face.rotateBorderingLines(clockwiseDirections, flips);
        end

        function rotateCounterClockwise(face)
            face.rotateGridCounterClockwise();
    
            counterClockwiseDirections = [Direction.Top Direction.Left Direction.Bottom Direction.Right];
            flips = flip(face.getFlipsForColor());

            face.rotateBorderingLines(counterClockwiseDirections, flips);
        end

        function setGrid(face, aGrid)
            face.grid = aGrid;
        end

        function grid = getGrid(face)
            grid = face.grid;
        end

        function row = getRow(face, rowNum)
            row = face.grid(rowNum, :);
        end

        function col = getCol(face, colNum)
            col = face.grid(:, colNum);
        end

        function setRow(face, rowNum, newRow)
            face.grid(rowNum, :) = newRow;
        end

        function setCol(face, colNum, newCol)
            face.grid(:, colNum) = newCol;
        end

        function n = numIncorrect(face)
            n = sum(face.grid ~= face.baseColor, 'all');
        end

        function n = numCorrect(face)
            n = sum(face.grid == face.baseColor, 'all');
        end

        function solved = isSolved(face)
            solved = all(face.grid == face.baseColor);
        end

        function reset(face)
            face.initializeGrid();
        end

        function show(face, ax)
            if numel(face.patches) ~= 0
                face.updatePatches();
            else
                face.createNewPatches(ax);
            end
        end
    
        function flat = flatten(face)
            flat = face.grid(:);
        end

        function masks = generateMasks(face)
            masks = zeros(6,3,3);

            colors = enumeration('Color');
            for color = 1:numel(colors)
                masks(color,:,:) = uint32(face.grid == color);
            end
        end

        function doesHavePatchLocations = hasPatchLocations(face)
            doesHavePatchLocations = ~isempty(face.patchLocations);
        end
    end

    methods (Static)
        function colStr = getColorString(color)
            switch color
                case Color.White
                    colStr = 'w';
                case Color.Green
                    colStr = 'g';
                case Color.Yellow
                    colStr = 'y';
                case Color.Blue
                    colStr = 'b';
                case Color.Orange
                    colStr = 'm';
                case Color.Red
                    colStr = 'r';
            end
        end
    end

    methods (Access=private)
        
        function initializeGrid(face)
            face.grid = ones(3, 'uint32') * face.baseColor;
        end

        function rotateBorderingLines(face, borderingDirections, flips)
            lines = zeros(4, 3);
            for directionIndex = 1:numel(borderingDirections)
                direction = borderingDirections(directionIndex);
                lines(directionIndex, :) = face.getClosestLineFromNeighboringFace(direction);
            end

            for directionIndex = 1:numel(borderingDirections)
                direction = borderingDirections(mod(directionIndex, 4)+1);

                lineToSet = lines(directionIndex, :);
                if flips(directionIndex)
                    lineToSet = flip(lineToSet);
                end

                face.setClosestLineFromNeighboringFace(direction, lineToSet);
            end
        end

        function line = getClosestLineFromNeighboringFace(face, direction)
            faceAndReturnDir = face.connectionsMap(direction.toInt());
            
            faceInDirection = faceAndReturnDir{1};
            returnDirection = faceAndReturnDir{2};

            line = faceInDirection.getLineInDirection(returnDirection);
        end

        function setClosestLineFromNeighboringFace(face, direction, newLine)
            faceAndReturnDir = face.connectionsMap(direction.toInt());
            
            faceInDirection = faceAndReturnDir{1};
            returnDirection = faceAndReturnDir{2};

            faceInDirection.setLineInDirection(returnDirection, newLine);
        end

        function rotateGridClockwise(face)
            face.grid = rot90(face.grid, 3);
        end

        function rotateGridCounterClockwise(face)
            face.grid = rot90(face.grid);
        end

        function flips = getFlipsForColor(face)
            switch face.baseColor
                case Color.White
                    flips = [1 0 0 1];
                case Color.Yellow
                    flips = [0 1 1 0];
                case Color.Blue
                    flips = [1 0 1 0];
                case Color.Green
                    flips = [0 1 0 1];
                otherwise
                    flips = [0 0 0 0];
            end
        end

        function line = getLineInDirection(face, direction)
            if direction == Direction.Top
                line = face.getRow(1);
            elseif direction == Direction.Bottom
                line = face.getRow(3);
            elseif direction == Direction.Left
                line = face.getCol(1);
            elseif direction == Direction.Right
                line = face.getCol(3);
            end
        end

        function setLineInDirection(face, direction, newLine)
            if direction == Direction.Top
                face.setRow(1, newLine);
            elseif direction == Direction.Bottom
                face.setRow(3, newLine);
            elseif direction == Direction.Left
                face.setCol(1, newLine);
            elseif direction == Direction.Right
                face.setCol(3, newLine);
            end
        end

        function createNewPatches(face, ax)
            face.patches = cell(3);

            for patchX = 1:3
                for patchY = 1:3
                    patchCoordinates = face.patchLocations{patchX, patchY};

                    xData = patchCoordinates(:, 1);
                    yData = patchCoordinates(:, 2);
                    zData = patchCoordinates(:, 3);

                    colStr = Face.getColorString(face.colorAt(patchX, patchY));

                    p = patch(ax, xData, yData, zData, colStr);
                    face.patches{patchX, patchY} = p;
                end
            end
        end

        function updatePatches(face)
            for patchX = 1:3
                for patchY = 1:3
                    p = face.patches{patchX, patchY};

                    colStr = Face.getColorString(face.colorAt(patchX, patchY));

                    p.FaceColor = colStr;
                end
            end
        end

    end
end

