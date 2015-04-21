% ======================================
%         --- Satisfaction ---
% --------------------------------------
% >>> satisfied(State, Goals)
%   Goals are satisfied withing the State.

% Empty goals are satisfied in every State.
satisfied(_, []).

% Check every Goal recursively.
satisfied( State, [Goal | OtherGoals]) :-
  member(Goal, State),
  satisfied( State, OtherGoals).

% TODO
% Satisfied instantiating clause
% Look for an instantiation that satisfies list of goals in state
satisfied( State, [Goal | OtherGoals])  :-
    instGoal(Goal),
    member(Goal, State),
    satisfied( State, OtherGoals).

% TODO
% Satisfied clause for pseudo-goal 'different'
satisfied( State, [Goal | OtherGoals])  :-
    holds(Goal),
    satisfied( State, OtherGoals).

% --------------------------------------
% >>> holds(Diff)

% TODO
% Uninstantiated and do not match
holds(different(X, Y)) :-
  var(X),
  var(Y),
  X \== Y.

% TODO
% Instantiated and different
holds(different(X, Y)) :-
  \+ var(X),
  \+ var(Y),
  \+ X == Y.
