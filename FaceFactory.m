classdef FaceFactory < handle
    properties (Access=private)
        colors = enumeration('Color')'
        faces
    end

    methods
        function factory = FaceFactory()
            factory.createFaces();
            factory.createConnectionsForAllColors();
        end

        function faces = getFaces(factory)
            faces = factory.faces;
        end

        % Creates the Face object for each Color and puts them in the faces
        % map. Each Face is fully constructed.
        function createFaces(factory)
            factory.faces = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

            for color = factory.colors
                factory.faces(color.toInt()) = Face(color);
            end
        end

        % Each Face is connected to it's neighboring Faces with a direction
        % map (Map<Direction, Face*>).
        %
        % The direction map is relative to the standard orientation of the
        % Face. Standard orientations are defined in the Direction class.
        function createConnectionsForAllColors(factory)
            allConnectionDirections = Direction.standardConnections();

            for color = factory.colors
                factory.createConnectionsForColor(color, allConnectionDirections)
            end
        end

        % Set the connectionsMap for the Face of a given color. Convert the
        % colors in the connectionsMap to the Face handle for that color.
        function createConnectionsForColor(factory, color, allConnectionDirections)
            face = factory.faces(color.toInt());

            face.connectionsMap = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
            connectionDirections = allConnectionDirections(color.toInt());

            for direction = keys(connectionDirections)
                colorAndReturnDir = connectionDirections(direction{1});
                returnDir = colorAndReturnDir{2};

                faceForColor = factory.faces(colorAndReturnDir{1}.toInt());

                face.connectionsMap(direction{1}) = {faceForColor, returnDir};
            end
        end
    end
end