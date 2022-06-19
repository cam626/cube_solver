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

            face.rotateBorderingLines(clockwiseDirections);
        end

        function rotateCounterClockwise(face)
            face.rotateGridCounterClockwise();
    
            counterClockwiseDirections = [Direction.Top Direction.Left Direction.Bottom Direction.Right];

            face.rotateBorderingLines(counterClockwiseDirections);
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

        function solved = isSolved(face)
            solved = all(face.grid == face.baseColor);
        end

        function show(face, ax)
            for patchX = 1:3
                for patchY = 1:3
                    patchCoordinates = face.patchLocations{patchX, patchY};

                    xData = patchCoordinates(:, 1);
                    yData = patchCoordinates(:, 2);
                    zData = patchCoordinates(:, 3);

                    colStr = Face.getColorString(face.colorAt(patchX, patchY));

                    patch(ax, xData, yData, zData, colStr);
                end
            end
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

        function rotateBorderingLines(face, borderingDirections)
            lines = zeros(4, 3);
            for directionIndex = 1:numel(borderingDirections)
                direction = borderingDirections(directionIndex);
                lines(directionIndex, :) = face.getClosestLineFromNeighboringFace(direction);
            end

            for directionIndex = 1:numel(borderingDirections)
                direction = borderingDirections(mod(directionIndex, 4)+1);
                face.setClosestLineFromNeighboringFace(direction, lines(directionIndex,:));
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

    end
end

