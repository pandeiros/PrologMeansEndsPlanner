% /=====================================\
% |  --- SIMPLE MEAND-ENDS PLANNER ---  |
% \=====================================/
% @authors
%   Paweł Kaczyński, Paweł Szymczyk
%
% Compile using SWI-Prolog
% ======================================


% ======================================
%           --- Modules ---
% --------------------------------------
%
% Consult these files:
:- [plan, achievement, goals, actions, states].

% ======================================
%     --- A State in our World ---
% --------------------------------------
%
%   c   d
%   a e b      <- blocks
%   -------
%   1 2 3 4    <- places

isBlock(a).     % Facts about blocks.
isBlock(b).
isBlock(c).
isBlock(d).
isBlock(e).

place(1).       % Facts about places.
place(2).
place(3).
place(4).

object(X) :-    % Object is a block OR place.
  isBlock(X) ;
  place(X).

%======================================
%          --- Main Program ---
% --------------------------------------
% Current state
state([clear(e), clear(4), clear(d), clear(c),              % Nothing is put on these elements.
        on(a,1), on(b,3), on(c,a), on(d,b), on(e,2)] ).     % on(X, Y) - X is put on Y.

% Example goal(s).
goals([on(a,b)]).

% Plan execution with depth generation.
initPlan(MaxLimit, State, Goals, Plan) :-
    plan(State, Goals, Plan, _),
    write('Plan: '),
    write(Plan).

%initPlan(_, _, _, _) :-
%    write('Nie znaleziono planu.').

showPlan :-
    stateX2(State),
    goalsX2(Goals),
    initPlan(10, State, Goals, _).
