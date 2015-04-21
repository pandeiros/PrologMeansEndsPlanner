% ======================================
%           --- Actions ---
% --------------------------------------
% >>> requires(Action, Conditions)

% Action is possible if all conditions are fulfilled.
requires(move(Block, From, To), % Action
    [clear(Block),              % Nothing is on the Block and on the target.
    clear(To),
    on(Block, From),            % Block is actually on the "From" object.
    different(From, To),        % We want to actually change place.
    different(Block, From)] ).  % We cannot move Block from itself.

% --------------------------------------
% >>> affect(Action, Effect)

% Action will lead to a certain Effect.
affect(move(Block,From,To),  [on(Block,To), clear(From)]).

% --------------------------------------
% >>> performAction(State, Action, NewState): Action executed in State produces NewState

%
performAction(State, Action, NewState) :-
  delete(Action, DelList),
  deleteAll(State, DelList, MidState), !,
  affect(Action, AddList),
  append(AddList, MidState, NewState).

% --------------------------------------
% >>> deleteAll(L1, L2, Diff)

%
deleteAll([], _, []).

%
deleteAll( [X | L1], L2, Diff)  :-
  member( X, L2),  !,
  deleteAll( L1, L2, Diff).

%
deleteAll([X | L1], L2, [X | Diff])  :-
  deleteAll( L1, L2, Diff).

% --------------------------------------
% >>> delete(Action, Effect)

% Action with certain effect to be removed.
delete(move(Block,From,To),  [on(Block,From), clear(To)]).
