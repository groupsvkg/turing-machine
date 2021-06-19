grammar TuringMachine;

// Parser Rules

// Lexer Rules
ID: [a-zA-Z]+;

NUMBER: DIGIT+ ('.' DIGIT+)?;

DIGIT: [0-9]+;

WHITESPACE: ' ' -> skip;
