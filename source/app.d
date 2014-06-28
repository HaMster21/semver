#! /usr/bin/env rdmd

import std.stdio;

int main(string[] args)
{
   debug std.stdio.writefln("Args: %s", args);

   if (args.length == 1) {
       printAbout();
       return 0;
   }

   switch (args[1]) {
       default: std.stdio.writeln("Option not supported"); break;
       case "-v" ,"--validate": {
           if (args.length > 2) {
               import semver: validate;
               if (validate(args[2])) return 0; else return 1;
           }
           else {
               std.stdio.writeln("a version string is needed for evaluation. Try 'semver -v 1.2.3'");
               break;
           }
       }
   }
   return 0;
}

void printAbout() {
    import std.stdio: writefln;

    writefln("");
    writefln("  semver Version 0.1.0");
    writefln("  https://github.com/mog-wi/semver");
    writefln("");
    writefln("  Usage:");
    writefln("    -v"); 
    writefln("    --validate <version> Validates a version string. Returns 0 on success, 1 when passed an invalid semantic version");
}
