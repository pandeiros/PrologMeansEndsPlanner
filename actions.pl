% ======================================
%           --- Actions ---
% --------------------------------------
% >>> requires(Action, CondGoals, Conditions)

% Action is possible if all conditions are fulfilled.
requires(move(Block, From, To),         % Action
        [clear(Block), clear(To)],              % CondGoals
        [on(Block, From), diff(From, To), diff(Block, From)]) :-   % Conditions.
    % different(From, To),        % We want to actually change place.
    % different(Block, From),     % We cannot move Block from itself.
    different(Block, To),
    nonvar(Block),
    var(From),
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
% >>> performAction(State, Action, NewState): Action executed in State produces NewState

%
performAction(State, Action, NewState, DebugLevel) :-
    delete(Action, DelList),
    deleteAll(State, DelList, MidState),
    affect(Action, AddList),
    append(AddList, MidState, NewState),
    printDebug('Action', Action, DebugLevel),
    printDebug('DelList', DelList, DebugLevel),
    printDebug('AddList', AddList, DebugLevel).

% --------------------------------------
% >>> deleteAll(L1, L2, Diff)

%
deleteAll([], _, []).

%
deleteAll([X | L1], L2, Diff)  :-
    member(X, L2),  !,
    deleteAll(L1, L2, Diff).

%
deleteAll([X | L1], L2, [X | Diff])  :-
    deleteAll(L1, L2, Diff).

% --------------------------------------
% >>> delete(Action, Effect)

% Action with certain effect to be removed.
delete(move(Block,From,To),  [on(Block,From), clear(To)]).
