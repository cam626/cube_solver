function encodedScrambles = convertMovesToOneHot(scrambles)
    encodedScrambles = cell(size(scrambles));
    for scrambleIdx = 1:numel(scrambles)
        scramble = scrambles{scrambleIdx};
        encodedScramble = onehotencode(scramble, 1, 'ClassNames', enumeration('Move'));
        encodedScrambles{scrambleIdx} = dlarray(encodedScramble, 'CTB');
    end
end

