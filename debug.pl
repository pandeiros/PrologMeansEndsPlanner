% ======================================
%       --- Debug Information ---
% --------------------------------------

printDebug(Msg, Var, Level) :-
    printDebugMargin(Level),
    printDebugLevel(Level),
    print(Msg),
    print(' : '),
    print(Var),
    print('\n').

printDebugLevel(Level) :-
    print('<'),
    print(Level),
    print('> ').

printDebugMargin(Level) :-
    Level > 0,
    print('   '),
    NewLevel is Level - 1,
    printDebugMargin(NewLevel).

printDebugMargin(0) :-
    print('   ').
