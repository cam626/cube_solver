
% Connections relative to a Face's standard orientation.
%
% Standard connections are given for each Face, which map connections to
% colors.
%
classdef Direction < uint32
    enumeration
        Left    (1)
        Right   (2)
        Top     (3)
        Bottom  (4)
    end

    methods
        function int = toInt(direction)
            int = uint32(direction);
        end
    end

    methods (Static)
        function allConnections = standardConnections()
            allConnections = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

            allConnections(Color.White.toInt()) = Direction.createWhiteStandardOrientationConnections();
            allConnections(Color.Green.toInt()) = Direction.createGreenStandardOrientationConnections();
            allConnections(Color.Yellow.toInt()) = Direction.createYellowStandardOrientationConnections();
            allConnections(Color.Blue.toInt()) = Direction.createBlueStandardOrientationConnections();
            allConnections(Color.Orange.toInt()) = Direction.createOrangeStandardOrientationConnections();
            allConnections(Color.Red.toInt()) = Direction.createRedStandardOrientationConnections();
        end

        function connections = createWhiteStandardOrientationConnections()
            connections = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

            connections(Direction.Left.toInt()) = {Color.Orange, Direction.Top};
            connections(Direction.Right.toInt()) = {Color.Red, Direction.Top};
            connections(Direction.Top.toInt()) = {Color.Blue, Direction.Bottom};
            connections(Direction.Bottom.toInt()) = {Color.Green, Direction.Top};
        end

        function connections = createGreenStandardOrientationConnections()
            connections = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

            connections(Direction.Left.toInt()) = {Color.Orange, Direction.Right};
            connections(Direction.Right.toInt()) = {Color.Red, Direction.Left};
            connections(Direction.Top.toInt()) = {Color.White, Direction.Bottom};
            connections(Direction.Bottom.toInt()) = {Color.Yellow, Direction.Top};
        end

        function connections = createYellowStandardOrientationConnections()
            connections = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

            connections(Direction.Left.toInt()) = {Color.Orange, Direction.Bottom};
            connections(Direction.Right.toInt()) = {Color.Red, Direction.Bottom};
            connections(Direction.Top.toInt()) = {Color.Green, Direction.Bottom};
            connections(Direction.Bottom.toInt()) = {Color.Blue, Direction.Top};
        end

        function connections = createBlueStandardOrientationConnections()
            connections = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

            connections(Direction.Left.toInt()) = {Color.Orange, Direction.Left};
            connections(Direction.Right.toInt()) = {Color.Red, Direction.Right};
            connections(Direction.Top.toInt()) = {Color.Yellow, Direction.Bottom};
            connections(Direction.Bottom.toInt()) = {Color.White, Direction.Top};
        end

        function connections = createOrangeStandardOrientationConnections()
            connections = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

            connections(Direction.Left.toInt()) = {Color.Blue, Direction.Left};
            connections(Direction.Right.toInt()) = {Color.Green, Direction.Left};
            connections(Direction.Top.toInt()) = {Color.White, Direction.Left};
            connections(Direction.Bottom.toInt()) = {Color.Yellow, Direction.Left};
        end

        function connections = createRedStandardOrientationConnections()
            connections = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

            connections(Direction.Left.toInt()) = {Color.Green, Direction.Right};
            connections(Direction.Right.toInt()) = {Color.Blue, Direction.Right};
            connections(Direction.Top.toInt()) = {Color.White, Direction.Right};
            connections(Direction.Bottom.toInt()) = {Color.Yellow, Direction.Right};
        end
    end
end