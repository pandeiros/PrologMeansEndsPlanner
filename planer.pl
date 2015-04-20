% /=====================================\
% |  --- SIMPLE MEAND-ENDS PLANNER ---  |
% \=====================================/
%
% ======================================
%           --- Modules ---
% --------------------------------------
%
% Consult these files:
:- include(plan).
:- include(satisfaction).

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

% Current state
state([clear(2), clear(4), clear(d), clear(c),     % Nothing is put on these elements.
        on(a,1), on(b,3), on(c,a), on(d,b)] ).     % on(X, Y) - X is put on Y.
