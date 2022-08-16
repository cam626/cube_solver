function env = createEnv()

    obsInfo = rlNumericSpec([54 1]);

    moves = enumeration('Move');
    actInfo = rlFiniteSetSpec(moves.toInt());

    env = rlFunctionEnv(obsInfo, actInfo, @stepFcn, @resetFcn);
end

function [observation, reward, isDone, loggedSignals] = stepFcn(action, loggedSignals)
    cube = loggedSignals.c;

    move = Move(action);
    Utils.applyMoveList(cube, move);

    reward = NumSolvedCostModel.getCost(cube);
    isDone = cube.isSolved();

    observation = cube.flatten();
end

function [initialObservation, loggedSignals] = resetFcn()
    cube = Cube;

    % TODO: Make the scrambles of random length
    s = Scrambler();
    s.scramble(cube, 15);

    initialObservation = cube.flatten();
    loggedSignals.c = cube;
end