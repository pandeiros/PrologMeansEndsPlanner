% /=====================================\
% |  --- SIMPLE MEAND-ENDS PLANNER ---  |
% \=====================================/
% @authors
%   Paweł Kaczyński, Kacper Domański
%
% Compile using SWI-Prolog
% ======================================


% ======================================
%           --- Modules ---
% --------------------------------------
%
% Consult these files:
:- [plan, debug, goals, actions, states].

% ======================================
%     --- A State in our World ---
% --------------------------------------
%   c
%   a
%   d   b      <- blocks
%   -------
%   1 2 3 4    <- places

isBlock(a).     % Facts about blocks.
isBlock(b).
isBlock(c).
isBlock(d).

place(1).       % Facts about places.
place(2).
place(3).
place(4).

object(X) :-    % Object is a block OR place.
  isBlock(X) ;
  place(X).

%======================================
%          --- Main Program ---
% -------------------------------------
%                 Data
%--------------------------------------
% Current state
state([clear(2), clear(4), clear(c), clear(b),     % Nothing is put on these elements.
        on(d,1), on(b,3), on(a,d), on(c,a)] ).     % on(X, Y) - X is put on Y.

% Example goal(s).
goals([on(d,b)]).

% Depth-increase iteration.
maxDepthLevel(10).

% Plan execution with depth generation.
initPlan(MaxLimit, State, Goals) :-
    plan(State, Goals, Plan, _, MaxLimit),
    nl,
    write("============================================\n  Plan: "),
    write(Plan),
    write("\n============================================").

%--------------------------------------
%            Entry point
%--------------------------------------
showPlan :-
    state(State),
    goals(Goals),
    maxDepthLevel(MaxDepth),
    initPlan(MaxDepth, State, Goals).
