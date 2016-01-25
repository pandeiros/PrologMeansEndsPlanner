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
% >>> goalsAchieved(State, Goals, DebugLevel)
%   Goals are achieved withing the State.

% Empty goals are achieved in every State.
goalsAchieved(_, [], _).

goalsAchieved(State, [Goal | OtherGoals], DebugLevel) :-
    checkGoal(State, Goal),
    goalsAchieved(State, OtherGoals, DebugLevel),
    printDebug('Goal achieved : ', Goal, DebugLevel).

% --------------------------------------
% >>> checkGoal(State, Goals)
%   Check single goal from goals.
%   It has many different variants.

checkGoal(State, on(X, Y)) :-
    member(on(X, Y), State).

checkGoal(State, clear(X)) :-
    member(clear(X), State).

checkGoal(State, clear(X/Y)) :-
    member(clear(X), State),
    checkGoal(State, Y).

checkGoal(State, on(X, Y/Z)) :-
    member(on(X, Y), State),
    checkGoal(State, Z).

checkGoal(State, diff(X, Y)) :-
    different(X, Y).

% --------------------------------------
% >>> achieves(Action, Goal)

% Goal is achievable if it is a member of Goals that
% will lead to Action being performed.
achieves(Action, Goal) :-
    affect(Action, Effect),
    member(Goal, Effect).
    % printDebug('Goals', Goals, 0).

% --------------------------------------
% >>> different(Diff)

different(X, Y) :-
    var(X),
    var(Y),
    X \== Y.

different(X, Y) :-
    nonvar(X),
    nonvar(Y),
    \+ X == Y.
