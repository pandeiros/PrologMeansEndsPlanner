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
goalsAchieved(_, [], _).

% Check every Goal recursively.
goalsAchieved(State, [Goal | OtherGoals], DebugLevel) :-
    member(Goal, State),

    printDebug('Goal achieved', Goal, DebugLevel),
    goalsAchieved(State, OtherGoals, DebugLevel).

%
goalsAchieved(State, [Goal | OtherGoals], DebugLevel)  :-
    instanceGoal(Goal),
    member(Goal, State),

    printDebug('Goal achieved', Goal, DebugLevel),
    goalsAchieved(State, OtherGoals, DebugLevel).

%
goalsAchieved(State, [Goal | OtherGoals], DebugLevel)  :-
    diff(Goal),

    printDebug('Goal achieved', Goal, DebugLevel),
    goalsAchieved(State, OtherGoals, DebugLevel).

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
    % isBlock(X).
    object(X).

%
instanceGoal(on(X, Y)) :-
    (var(X) ; var(Y)),
    isBlock(X),
    object(Y).

% --------------------------------------
% >>> diff(Diff)

%
diff(different(X, Y)) :-
    % var(X),
    % var(Y),
    X \== Y.

%
diff(different(X, Y)) :-
    % \+ var(X),
    % \+ var(Y),
    \+ X == Y.
