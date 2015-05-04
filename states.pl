% ======================================
%  --- Different states in our World ---
% --------------------------------------
%   > State X1 <
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
%   > State X2 <
%
%   b
%   a      <- blocks
%   ---
%   1 2    <- places

isBlock(b).

stateX2([clear(b), clear(2),
        on(a,1), on(b,a)]).
