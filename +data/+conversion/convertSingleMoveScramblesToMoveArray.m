function moveArray = convertSingleMoveScramblesToMoveArray(scrambles)
    moveArray = dlarray(cellfun(@(a) a, scrambles), 'BC');
end

