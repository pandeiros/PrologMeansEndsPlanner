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
    goalsAchieved(State, Goals).

% Otherwise, we decompose plan into PrePlan and the rest - PostPlan.
plan(State, Goals, Plan, FinalState) :-
    append(PrePlan, [Action | PostPlan], Plan),       % Plan decomposition.
    chooseGoal(State, Goals, Goal),                   % Get current Goal from Goals, that is not a memeber of State.
    achieves(Action, Goal),                           %
    requires(Action, Conditions),
    plan(State, Conditions, PrePlan, MidState_1),
    performAction(MidState_1, Action, MidState_2),
    plan(MidState_2, Goals, PostPlan, FinalState).
