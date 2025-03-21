classdef ScrambleDatasetConfig < handle
    properties
        minScrambleLen (1, 1) double = 1
        maxScrambleLen (1, 1) double = 15
    end

    methods
        function setMinScrambleLen(obj, aMinScrambleLen)
            obj.minScrambleLen = aMinScrambleLen;
        end

        function minScrambleLen = getMinScrambleLen(obj)
            minScrambleLen = obj.minScrambleLen;
        end

        function setMaxScrambleLen(obj, aMaxScrambleLen)
            obj.maxScrambleLen = aMaxScrambleLen;
        end

        function maxScrambleLen = getMaxScrambleLen(obj)
            maxScrambleLen = obj.minScrambleLen;
        end
    end
end