% ======================================
%  --- Different states in our World ---
% --------------------------------------
%   > State 1 <
%
%   c
%   a
%   d   b      <- blocks
%   -------
%   1 2 3 4    <- places

state1([clear(2), clear(4), clear(c), clear(b),
        on(d,1), on(b,3), on(a,d), on(c,a)] ).
goals1([on(d,b)]).

% Simple case, should solve in 3 steps.

% --------------------------------------
%   > State 2 <
%
%   c
%   a
%   d   b      <- blocks
%   -------
%   1 2 3 4    <- places

state2([clear(2), clear(4), clear(c), clear(b),
        on(d,1), on(b,3), on(a,d), on(c,a)] ).
goals2([on(d,4)]).

% Tricky goal, because without protecting goals,
% c will move to 2, then a to 4, then d cannot move
% to 4, so a will move to... d again! And so on.
% Should take 4 steps.

% --------------------------------------
%   > State 3 <
%
%   c   f
%   a   e
%   d   b      <- blocks
%   -------
%   1 2 3 4    <- places

state3([clear(2), clear(4), clear(c), clear(f),
        on(d,1), on(b,3), on(a,d), on(c,a), on(e, b), on(f, e)] ).
goals3([on(d,b)]).

% Additional steps to make: put e and f somewhere.

% --------------------------------------
%   > State 4 <
%
%   c   f
%   a   e
%   d   b      <- blocks
%   -------
%   1 2 3 4    <- places

state4([clear(2), clear(4), clear(c), clear(f),
        on(d,1), on(b,3), on(a,d), on(c,a), on(e, b), on(f, e)] ).
goals4([on(d,b), on(a, d), on(c, 3)]).

% Added additional goals <- tricky ones....
