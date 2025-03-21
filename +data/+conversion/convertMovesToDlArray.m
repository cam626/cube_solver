function scrambles = convertMovesToDlArray(scrambles)
    for scrambleIdx = 1:numel(scrambles)
        scramble = scrambles{scrambleIdx};
        scrambles{scrambleIdx} = dlarray(scramble, 'CTB');
    end
end

