% ======================================
%           --- Actions ---
% --------------------------------------
% >>> requires(Action, CondGoals, Conditions)

% Action is possible if all conditions are fulfilled.
requires(move(Block, From, To),         % Action
        [clear(Block), clear(To)],              % CondGoals
        [on(Block, From)]) :- %, diff(From, To), diff(Block, From)]) :-   % Conditions.
    different(Block, To),
    nonvar(Block),
    var(From),
    \+ place(Block),
    nonvar(To).

requires(move(Block, From, To),
        [clear(Block/ on(Block, From))],
        [clear(To), diff(Block, To)]) :-
    var(Block),
    nonvar(From),
    var(To).

% --------------------------------------
% >>> affect(Action, Effect)

% Action will lead to a certain Effect.
affect(move(Block,From,To),  [on(Block,To), clear(From)]).

% --------------------------------------
% >>> performAction(State, Action, NewState)
% Action executed in State produces NewState

performAction(State, move(Block, From, To), NewState, DebugLevel) :-
    delete(move(Block, From, To), DelList),
    deleteAll(State, DelList, MidState),
    affect(move(Block, From, To), AddList),
    append(AddList, MidState, NewState),
    printDebug('Action', move(Block, From, To), DebugLevel),
    printDebug('DelList', DelList, DebugLevel),
    printDebug('AddList', AddList, DebugLevel).

% --------------------------------------
% >>> instanceAction(Action, Conditions, State, InstAction)
% Check conditions and simplify action.
instanceAction(move(Block, From/_, To), [Condition],
    State, move(Block, From, To)) :-

    checkGoal(State, Condition).

instanceAction(move(Block, From/_, To), [Condition1, Condition2],
    State, move(Block, From, To)) :-

    checkGoal(State, Condition1),
    checkGoal(State, Condition2).

instanceAction(move(Block, From, To), [Condition1, Condition2],
    State, move(Block, From, To)) :-

    checkGoal(State, Condition1),
    checkGoal(State, Condition2).

% --------------------------------------
% >>> checkAction(Action, Protected)
% Check whether Action does not break fulfilled goals.
checkAction(_, []).
checkAction(Action, Protected) :-
    delete(Action, Relations),
    \+ (
        member(Goal, Relations),
        member(Goal, Protected)
    ).

% --------------------------------------
% >>> deleteAll(L1, L2, Diff)

deleteAll([], _, []).

deleteAll([X | L1], L2, Diff)  :-
    member(X, L2),  !,
    deleteAll(L1, L2, Diff).

deleteAll([X | L1], L2, [X | Diff])  :-
    deleteAll(L1, L2, Diff).

% --------------------------------------
% >>> delete(Action, Effect)

% Action with certain effect to be removed.
delete(move(Block, From/_, To), [on(Block, From), clear(To)]).

delete(move(Block,From,To),  [on(Block,From), clear(To)]).
