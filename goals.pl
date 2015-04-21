% ======================================
%           --- Goals ---
% --------------------------------------
% >>> selectGoal(State, Goals, Goal)

% Select Goal that is in Goals, but not in current State.
selectGoal(State, Goals, Goal) :-
  member(Goal, Goals),
  \+ member(Goal, State).      % Not satisfied yet.

% --------------------------------------
% >>> achieves(Action, Goal)

% Goal is achievable if it is a member of Goals that
% will lead to Action being performed.
achieves(Action, Goal) :-
  affect(Action, Goals),
  member(Goal, Goals).
