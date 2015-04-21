% ======================================
%           --- Goals ---
% --------------------------------------
% >>> chooseGoal(State, Goals, Goal)

% Choose Goal that is in Goals, but not in current State.
chooseGoal(State, Goals, Goal) :-
  member(Goal, Goals),
  \+ member(Goal, State).      % Not achieved yet.

% --------------------------------------
% >>> instanceGoal(Goal)

%
instanceGoal(clear(X)) :-
  var(X),
  isBlock(X).

%
instanceGoal(on(X, Y)) :-
  var(X),
  var(Y),
  isBlock(X),
  object(Y).

% --------------------------------------
% >>> holds(Diff)

%
holds(different(X, Y)) :-
    var(X),
    var(Y),
    X \== Y.

%
holds(different(X, Y)) :-
    \+ var(X),
    \+ var(Y),
    \+ X == Y.
