% ======================================
%           --- Goals ---
% --------------------------------------
% >>> chooseGoal(State, Goals, Goal)

% Choose Goal that is in Goals, but not in current State.
chooseGoal(State, Goals, Goal, RestGoals) :-
  member(Goal, Goals),
  \+ member(Goal, State),      % Not achieved yet.
  subtract(Goals, [Goal], RestGoals).

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
    diff(Goal),
    goalsAchieved(State, OtherGoals).

% --------------------------------------
% >>> achieves(Action, Goal)

% Goal is achievable if it is a member of Goals that
% will lead to Action being performed.
achieves(Action, Goal) :-
    affect(Action, Goals),
    member(Goal, Goals).

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
% >>> diff(Diff)

%
diff(different(X, Y)) :-
    var(X),
    var(Y),
    X \== Y.

%
diff(different(X, Y)) :-
    \+ var(X),
    \+ var(Y),
    \+ X == Y.
