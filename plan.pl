% ======================================
%            --- Plan ---
% --------------------------------------
% >>> plan(State, Goals, Plan, FinalState)
%   State : Current or initial state.
%   Goals : What do we want to achieve.
%   Plan  : Current plan (sequence of actions).
%   FinalState : State of the world we treat as satisfying for now.

plan(State, Goals, Plan, FinalState) :-
    plan(State, Goals, [], Plan, FinalState).

% If Plan is empty, only Goals are checked for current State
% (However, most of the time a plan decomposition is essential).
plan(State, Goals, _, [], State) :-
    % Debug
    debug1(State, Goals, Plan, FinalState),

    goalsAchieved(State, Goals).

% Otherwise, we decompose plan into PrePlan and the rest - PostPlan.
plan(State, Goals, Protected, Plan, FinalState) :-
    % Debug
    debug2(State, Goals, Plan, FinalState),

    append(PrePlan, [Action | PostPlan], Plan),       % Plan decomposition.
    chooseGoal(State, Goals, Goal, RestGoals),                   % Get current Goal from Goals, that is not a memeber of State.
    achieves(Action, Goal),
    requires(Action, Conditions),
    preserves(Action, Protected),
    plan(State, Conditions, Protected, PrePlan, MidState_1),
    processConstraints(Action, MidState_1),
    write('PERFORM ACTION - \n'),
    performAction(MidState_1, Action, MidState_2),
    plan(MidState_2, Goals, [Goal | Protected], PostPlan, FinalState).

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

% Debug info
debug1(S, G, P, F) :-
    write('CHECK '),
    debug2(S,G,P,F).

debug2(S, G, P, F) :-
    write('PLAN - '),
    write('State: '),
    write(S),
    write(',  Goals: '),
    write(G),
    write(',  Plan: '),
    write(P),
    write(',  Final: '),
    write(F),
    write('\n').
