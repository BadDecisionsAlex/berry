
#include "be_object.h"
#include "be_opcode.h"

const char *
be_opcode2str( bopcode op )
{
  static const char * const opcode_tab[] =
  {
    "ADD",    "SUB",      "MUL",        "DIV",          "MOD",
    "LT",
    "LE",
    "EQ",     "NE",       "GT",         "GE",
    "AND",    "OR",       "XOR",        "SHL",          "SHR",
    "RANGE",
    "NEG",
    "NOT",    "LDNIL",    "LDBOOL",
    "LDINT",  "LDCONST",  "MOVE",       "GETGBL",       "SETGBL",
    "GETUPV",
    "SETUPV",
    "JMP",
    "JMPT",   "JMPF",     "CALL",       "RET",          "CLOSURE",
    "GETMBR",
    "GETMET",
    "SETMBR",
    "GETIDX", "SETIDX",   "SETSUPER",   "CLOSE",        "IMPORT"
  };

  return( op < array_count( opcode_tab ) ? opcode_tab[op] : "ERROP" );
}
