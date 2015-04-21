% ======================================
%         --- Goals Achieved ---
% --------------------------------------
% >>> goalsAchieved(State, Goals)
%   Goals are achieved withing the State.

% Empty goals are achieved in every State.
goalsAchieved(_, []).

% Check every Goal recursively.
goalsAchieved(State, [Goal | OtherGoals]) :-
  member(Goal, State),
  goalsAchieved(State, OtherGoals).

%
goalsAchieved(State, [Goal | OtherGoals])  :-
    instanceGoal(Goal),
    member(Goal, State),
    goalsAchieved( State, OtherGoals).

%
goalsAchieved(State, [Goal | OtherGoals])  :-
    holds(Goal),
    goalsAchieved(State, OtherGoals).

% --------------------------------------
% >>> achieves(Action, Goal)

% Goal is achievable if it is a member of Goals that
% will lead to Action being performed.
achieves(Action, Goal) :-
  affect(Action, Goals),
  member(Goal, Goals).
