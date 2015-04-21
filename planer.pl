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
:- [plan, satisfaction, goals, actions].

% ======================================
%     --- A State in our World ---
% --------------------------------------
%
%   c   d
%   a   b      <- blocks
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

% Current state
state([clear(2), clear(4), clear(d), clear(c),     % Nothing is put on these elements.
        on(a,1), on(b,3), on(c,a), on(d,b)] ).     % on(X, Y) - X is put on Y.

% ======================================
%          --- Main Query ---
% --------------------------------------
%  state(State), plan(State, [on(a,b)], Plan, FinState).