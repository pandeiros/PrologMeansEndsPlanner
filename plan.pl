% ======================================
%            --- Plan ---
% --------------------------------------
% >>> plan(State, Goals, Plan, FinalState)
%   State : Current or initial state.
%   Goals : What do we want to achieve.
%   Plan  : Current plan (sequence of actions).
%   FinalState : State of the world we treat as satisfying for now.
%   MaxLimit : Maximum number of iteration for pre- and post-plan combined.

plan(State, Goals, Plan, FinalState, MaxLimit) :-
    generateNum(0, MaxLimit, N),
    printDebug('===== ITERATION ======', N, 0),
    plan(State, Goals, [], Plan, FinalState, N, 0).

% If Plan is empty, only Goals are checked for current State
% (However, most of the time a plan decomposition is essential).
plan(State, Goals, _, [], State, N, DebugLevel) :-
    NewDebugLevel is DebugLevel + 1,
    printDebug('PLAN - Checking goals', Goals, NewDebugLevel),
    NewDebugLevel2 is DebugLevel + 2,
    goalsAchieved(State, Goals, NewDebugLevel2).

% Otherwise, we decompose plan into PrePlan and the rest - PostPlan.
plan(State, Goals, Protected, Plan, FinalState, N, DebugLevel) :-
    NewDebugLevel is DebugLevel + 1,
    printDebug('PLANNING...', '',NewDebugLevel),
    printDebug('State', State, NewDebugLevel),
    printDebug('Current goals', Goals, NewDebugLevel),

    chooseGoal(State, Goals, Goal, RestGoals),        % Get current Goal from Goals, that is not a memeber of State.
    printDebug('Goal', Goal, NewDebugLevel),
    printDebug('Rest goals', RestGoals, NewDebugLevel),

    achieves(Action, Goal),
    printDebug('Action', Action, NewDebugLevel),

    requires(Action, CondGoals, Conditions),
    printDebug('CondGoals', CondGoals, NewDebugLevel),
    printDebug('Conditions', Conditions, NewDebugLevel),

    %preserves(Action, Protected),

    printDebug('CALL PRE-PLAN', '', NewDebugLevel),
    plan(State, CondGoals, Protected, PrePlan, MidState_1, N, NewDebugLevel),

    %processConstraints(Action, MidState_1),

    printDebug('EXIT PRE-PLAN', '', NewDebugLevel),
    printDebug('Conditions', Conditions, NewDebugLevel),
    printDebug('PERFORM ACTION', '', NewDebugLevel),
    NewDebugLevel2 is DebugLevel + 2,
    performAction(MidState_1, Action, MidState_2, NewDebugLevel2),
    printDebug('MidState 1', MidState_1, NewDebugLevel),
    printDebug('MidState 2', MidState_2, NewDebugLevel),

    printDebug('CALL POST-PLAN', '', NewDebugLevel),
    plan(MidState_2, Goals, [Goal | Protected], PostPlan, FinalState, N, NewDebugLevel),
    printDebug('EXIT POST-PLAN', '', NewDebugLevel),

    appendAction(PrePlan, Action, PostPlan, Plan).       % Plan decomposition.


% --------------------------------------
% >>> preserves(Action, Goals)

preserves(Action, Goals) :-
    delete(Action, Relations),
    \+ (
    member(Goal, Relations),
    member(Goal, Goals)
    ).

% --------------------------------------
% >>> processConstraints(Action, State)

processConstraints(move(Block, From, To), State) :-
    member(on(Block, From), State),
    member(clear(To), State),
    member(clear(Block), State),
    isBlock(Block),
    object(To),
    To \== Block,
    object(From),
    From \== To,
    Block \== From.

% --------------------------------------
% >>> generateNum(Min, Max, N)

% Generate number between Min and Max (via increment).
generateNum(Min, Max, N) :-
    Min < Max,
    NewMax is Max - 1,
    generateNum(Min, NewMax, N).

% First attempt end in setting N to Min.
generateNum(Min, Max, Max).
