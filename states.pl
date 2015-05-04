% ======================================
%  --- Different states in our World ---
% --------------------------------------
%   > State X1 <    WORKING
%
%   a      <- blocks
%   ---
%   1 2    <- places

isBlock(a).     % Facts about blocks.

place(1).       % Facts about places.
place(2).

stateX1([clear(a), clear(2),
        on(a,1)]).

goalsX1([on(a,2)]).

% --------------------------------------
%   > State X2 <    WORKING
%
%   b
%   a      <- blocks
%   ---
%   1 2    <- places

isBlock(b).

goalsX2([on(a,b)]).

stateX2([clear(b), clear(2),
        on(a,1), on(b,a)]).

% --------------------------------------
%   > State X3 <
%
%   f
%   e
%   d
%   c
%   b
%   a      <- blocks
%   ---
%   1 2    <- places

isBlock(c).
% isBlock(d).
% isBlock(e).
% isBlock(f).

goalsX3([on(a,b)]).

stateX3([clear(c), clear(2),
        on(a,1), on(b,a), on(c,b)]).
