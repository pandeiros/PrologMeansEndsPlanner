% ======================================
%            --- Plan ---
% --------------------------------------
% >>> plan(State, Goals, Plan, FinalState)
%   State : Current or initial state.
%   Goals : What do we want to achieve.
%   Plan  : Current plan (sequence of actions).
%   FinalState : State of the world we treat as satisfying for now.

plan(State, Goals, Plan, FinalState) :-
    plan(State, Goals, [], Plan, FinalState, 0).

% If Plan is empty, only Goals are checked for current State
% (However, most of the time a plan decomposition is essential).
plan(State, Goals, _, [], State, DebugLevel) :-
    NewDebugLevel is DebugLevel + 1,
    printDebug('PLAN (CHECK)', '', NewDebugLevel),
    goalsAchieved(State, Goals).

% Otherwise, we decompose plan into PrePlan and the rest - PostPlan.
plan(State, Goals, Protected, Plan, FinalState, DebugLevel) :-
    NewDebugLevel is DebugLevel + 1,
    printDebug('PLAN', '',NewDebugLevel),
    printDebug('State', State, NewDebugLevel),
    printDebug('Current goals', Goals, NewDebugLevel),

    chooseGoal(State, Goals, Goal, RestGoals),        % Get current Goal from Goals, that is not a memeber of State.
    printDebug('Goal', Goal, NewDebugLevel),

    achieves(Action, Goal),
    printDebug('Action', Action, NewDebugLevel),

    requires(Action, Conditions),
    printDebug('Conditions', Conditions, NewDebugLevel),

    %preserves(Action, Protected),

    printDebug('CALL PRE-PLAN', '', NewDebugLevel),
    plan(State, Conditions, Protected, PrePlan, MidState_1, NewDebugLevel),

    %processConstraints(Action, MidState_1),

    printDebug('EXIT PRE-PLAN', '', NewDebugLevel),

    performAction(MidState_1, Action, MidState_2),

    printDebug('CALL POST-PLAN', '', NewDebugLevel),
    plan(MidState_2, Goals, [Goal | Protected], PostPlan, FinalState, NewDebugLevel),
    printDebug('EXIT POST-PLAN', '', NewDebugLevel),

    append(PrePlan, [Action | PostPlan], Plan).       % Plan decomposition.


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
% >>> generateNum(From, Max, N)

% Generate number between Min and Max (via increment).
generateNum(Min, Max, N) :-
    Min < Max,
    NewMax is Max - 1,
    generateNum(Min, NewMax, N).

% First attempt end in setting N to Min.
generateNum(Min, Max, Max).
