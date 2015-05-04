% ======================================
%            --- Plan ---
% --------------------------------------
% >>> plan(State, Goals, Plan, FinalState)
%   State : Current or initial state.
%   Goals : What do we want to achieve.
%   Plan  : Current plan (sequence of actions).
%   FinalState : State of the world we treat as satisfying for now.

% If Plan is empty, only Goals are checked for current State
% (However, most of the time a plan decomposition is essential).
plan(State, Goals, [], State) :-
    debug1(State, Goals, Plan, FinalState),
    goalsAchieved(State, Goals).

% Otherwise, we decompose plan into PrePlan and the rest - PostPlan.
plan(State, Goals, Plan, FinalState) :-
    % Debug
    debug2(State, Goals, Plan, FinalState),

    chooseGoal(State, Goals, Goal),                   % Get current Goal from Goals, that is not a memeber of State.
    achieves(Action, Goal),
    requires(Action, Conditions),
    plan(State, Conditions, PrePlan, MidState_1),
    performAction(MidState_1, Action, MidState_2),
    plan(MidState_2, Goals, PostPlan, FinalState),
    append(PrePlan, [Action | PostPlan], Plan).     % Plan decomposition.

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
    write('CHECK GOALS - '),
    debug2(S,G,P,F).
    
debug2(S, G, P, F) :-
    write('State: '),
    write(S),
    write(',  Goals: '),
    write(G),
    write(',  Plan: '),
    write(P),
    write(',  Final: '),
    write(F),
    write('\n').
