# Unix Calculator

A Unix/Linux calculator and compiler-style project built using **Lex/Flex, Yacc/Bison, and x86-64 assembly**.

The project implements a small calculator language by combining lexical analysis, parsing, code generation, and assembly support. Lex/Flex identifies tokens from the input, while Yacc/Bison defines the grammar and processes expressions and statements. The generated output is used with x86-64 assembly routines to produce executable programs.

The included test programs exercise different language features and computations, including factorial, greatest common divisor (GCD), harmonic calculations, loops, and π-related calculations. A Makefile and driver script support building and testing the implementation.