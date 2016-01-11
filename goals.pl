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



checkGoal(State, on(X, Y)) :-
    % nonvar(X),
    % nonvar(Y),
    member(on(X, Y), State).

    % goalsAchieved(State, OtherGoals, DebugLevel),
    % printDebug('Goal achieved (on) ', X, Y, DebugLevel).

checkGoal(State, clear(X)) :-
    % nonvar(X),
    member(clear(X), State).

checkGoal(State, clear(X/Y)) :-
    member(clear(X), State),
    checkGoal(State, Y).

    % goalsAchieved(State, OtherGoals, DebugLevel),
    % printDebug('Goal achieved (clear/) ', X, Y, DebugLevel).

    % goalsAchieved(State, OtherGoals),
    % printDebug('Goal achieved (clear) ', X).


checkGoal(State, on(X, Y/Z)) :-
    member(on(X, Y), State),
    checkGoal(State, Z).

checkGoal(State, diff(X, Y)) :-
    member(diff(X, Y), State),
    different(X, Y).


% % Check every Goal recursively.
% goalsAchieved(State, [Goal | OtherGoals], DebugLevel) :-
%     member(Goal, State),
%
%     goalsAchieved(State, OtherGoals, DebugLevel),
%     printDebug('Goal achieved (member)', Goal, DebugLevel).
%
% %
% goalsAchieved(State, [Goal | OtherGoals], DebugLevel)  :-
%     instanceGoal(Goal),
%     member(Goal, State),
%
%     goalsAchieved(State, OtherGoals, DebugLevel),
%     printDebug('Goal achieved (instance)', Goal, DebugLevel).
%
% %
% goalsAchieved(State, [Goal | OtherGoals], DebugLevel)  :-
%     diff(Goal),
%
%     goalsAchieved(State, OtherGoals, DebugLevel),
%     printDebug('Goal achieved (diff)', Goal, DebugLevel).

% --------------------------------------
% >>> achieves(Action, Goal)

% Goal is achievable if it is a member of Goals that
% will lead to Action being performed.
achieves(Action, Goal) :-
    affect(Action, Effect),
    member(Goal, Effect).
    % printDebug('Goals', Goals, 0).

% --------------------------------------
% >>> instanceGoal(Goal)

%
instanceGoal(clear(X)) :-
    var(X),
    object(X).

%
instanceGoal(on(X, Y)) :-
    var(X),
    var(Y),
    isBlock(X),
    object(Y).

% --------------------------------------
% >>> different(Diff)

different(X, Y) :-
    var(X),
    var(Y),
    X \== Y.

different(X, Y) :-
    nonvar(X),
    nonvar(Y),
    X \== Y.

% different(X, Y) :-
%     var(X),
%     nonvar(Y) ;
%     nonvar(X),
%     var(Y).

% differen
% diff(different(X, Y)) :-
%     var(X),
%     var(Y),
%     X \== Y.
%
% %
% diff(different(X, Y)) :-
%     \+ var(X),
%     \+ var(Y),
%     \+ X == Y.
