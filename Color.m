classdef Color < uint32
    enumeration
        White   (1)
        Green   (2)
        Yellow  (3)
        Blue    (4)
        Red     (5)
        Orange  (6)
    end

    methods
        function int = toInt(color)
            int = uint32(color);
        end
    end

end

