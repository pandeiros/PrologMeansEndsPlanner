% ======================================
%           --- Actions ---
% --------------------------------------
% >>> can(Action, Conditions)

% Action is possible if all conditions are fulfilled.
can(move(Block, From, To),      % Action
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
% >>> apply(State, Action, NewState): Action executed in State produces NewState

apply(State, Action, NewState) :-
  deletes(Action, DelList),
  delete_all(State, DelList, State1), !,
  affect(Action, AddList),
  append(AddList, State1, NewState).

% --------------------------------------
% >>> instGoal(Goal)
%  TODO
instGoal(clear(X)) :-
    var(X),
    isBlock(X).

instGoal(on(X, Y)) :-
    var(X),
    var(Y),
    isBlock(X),
    object(Y).

% --------------------------------------
%  delete_all( L1, L2, Diff) if Diff is set-difference of L1 and L2

% TODO
delete_all( [], _, []).

delete_all( [X | L1], L2, Diff)  :-
  member( X, L2),  !,
  delete_all( L1, L2, Diff).

delete_all( [X | L1], L2, [X | Diff])  :-
  delete_all( L1, L2, Diff).
% --------------------------------------
% deletes( Action, Relationships): Action destroys Relationships

deletes( move(X,From,To), [ on(X,From), clear(To)]).
