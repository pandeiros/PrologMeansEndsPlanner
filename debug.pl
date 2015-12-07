% ======================================
%       --- Debug Information ---
% --------------------------------------

printDebug(Msg, Var, Level) :-
    printDebugMargin(Level),
    printDebugLevel(Level),
    write(Msg),
    write(" : "),
    write(Var),
    nl.

printDebugLevel(Level) :-
    write("<"),
    write(Level),
    write("> ").

printDebugMargin(Level) :-
    Level > 0,
    write("   "),
    NewLevel is Level - 1,
    printDebugMargin(NewLevel).

printDebugMargin(0) :-
    write("   ").
