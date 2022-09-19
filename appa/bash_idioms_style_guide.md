## The bash Idioms Style Guide

This is a copy of the points in chapter 11 of _bash Idioms_ but without the commentary and examples.  There's also a Markdown file in the examples directory so you can download and tweak it as desired, then render or include it as needed using `pandoc` or some other tool.  Get the code from the https://github.com/vossenjp/bashidioms-examples/tree/master/appa[book's GitHub page].


### The _bash Idioms_ Style Guide Is Not Portable

This _bash Idioms_ style guide is specifically for bash, so it is not portable to POSIX, Bourne, Dash, or other shells.  If you need to write for those shells, you will need to test and tweak this guide to account for the supported syntax and feature of those shells.

Be especially careful in Docker or other containers where `/bin/sh` is not bash and `/bin/bash` may not even exist!  This applies to Internet of Things and other constrained environments such as industrial controllers.  See "bash in Containers" in the preface and "Shebang" in chapter 9 of _bash Idioms_.


### Readability

Readability of your code is important!  Or as Python says, _readability counts._  You only write it once, but you (and others) will probably read it many times.  Spend the extra few seconds or minutes thinking about the poor clueless person trying to read the code next year...it's very likely to be you.  There's a balance and a tension between abstraction (Don't Repeat Yourself) and readability:

* KISS (Keep It Simple, Stupid!).
* _Readability_: don't be "clever," be clear.
* Good names are critical!
* _Always use a header._
* If at all possible, emit something useful for `-h`, `--help`, and incorrect arguments!
    * Prefer using a "here" document (with leading tabs) rather than a bunch of echo lines because there's less friction when you need to update and probably rewrap it later.
* Use `source` (instead of `.`, which is easy to miss seeing and harder to search for) to include config files, which should end in `.cfg` (or `.conf` or whatever your standard is).
* If at all possible, use https://oreil.ly/6QyeH[ISO-8601] dates for everything.
* If at all possible, keep lists of things in alphabetical order; this prevents duplication and makes it easier to add or remove items. Examples include IP addresses (use GNU `sort -V`), hostnames, packages to install, `case` statements, and contents of variables or arrays/lists.
* If possible, use long arguments to commands for readability, e.g., use `diff --quiet` instead of `diff -q`, though watch out for portability to non-GNU/Linux systems.
    * If any options are short or obscure, add comments.
    * Strongly consider documenting why you chose or needed the options you chose, and even options you considered but didn't use for some reason.
    * Definitely document any options that might seem like a good idea but that actually can cause problems, especially if you commonly use them elsewhere.


### Comments

* _Always use a header._
* Write your comments for the new person on the team a year from now.
* Comment your functions.
* Do not comment on what you did. Comment on why you did, or did not do, something.
    * Exception: comment on what you did when bash itself is obscure.
* Consider adding comments about external program options, especially if they are short or obscure.
* Use an initial capital on the first word of the comment, but omit ending punctuation unless the comment is more than one sentence.


### Names

* Good names are critical!
* Global variables and constants are in UPPER case.
    * Prefer not to make changes to global variables, but sometimes that's just much simpler (KISS).
    * Use `readonly` or `declare -r` for constants.
* Other variables are in lowercase.
* Functions are in Mixed_Case.
* Use "_", not CamelCase, in place of space (remember, "-" is not allowed in variable names).
* Use bash arrays carefully; they can be hard to read (see chapter 7 of _bash Idioms_). `for var in $regular_var` often works as well.
* Replace `$1`, `$2`, .. `$N` with readable names ASAP.
    * That makes everything much more debuggable and readable, but it also makes it easy to have defaults and add or rearrange arguments.
* Distinguish between types of referents, like `$input_file` versus `$input_dir`.
* Use consistent "FIXME" and "TODO" labels, with names and ticket numbers if appropriate.


### Functions

* _Always use a header._
* Good names are critical!
* Functions must be defined before they are used.
    * Group them at the top, and use two blank lines and a function separator between each function.
    * Do _not_ intersperse code between functions!
* Use Camel_Case and "_" to make function names stand out from variable names.
* Use `function My_Func_Name {` instead of `My_Func_Name() {` because it's clearer and easier to `grep -P '^\s*function '`.
* Each function should have comments defining what it does, inputs (including GLOBALS), and outputs.
* When you have useful, standalone pieces of code, or any time you use the same (or substantially similar) block of code more than once, make them into functions.  If they are very common, like logging or emailing, consider creating a "library," that is, a single common file you can source as needed.
    * Prefix "library" functions with "_", like `_Log` or some other prefix.
* Consider using "filler" words for readability in arguments if it makes sense, then define them as `local junk1="$2" # Unused filler`, e.g.:
    * `_Create_File_If_Needed "/path/to/$file" containing 'important value'`
* Do use the `local` builtin when setting variables in functions.
    * But be aware that successfully being "local," it will mask a failed return code, so declare and assign it on separate lines if using command substitution, like `local my_input` and then `my_input="$(some-command)"`.
* For any function longer than about 25 lines, close it with `} # End of function MyFuncName` to make it easier to track where you are in the code on your screen. For functions shorter than 25 lines, this is optional but encouraged unless it gets too cluttered.
* Don't use a `main` function; it's almost always just an unnecessary layer.
    * That said, using "main" makes sense to Python and C programmers, or if the code is also used as a library, and it may be required if you do a lot of unit testing.
* Consider using two blank lines and a main separator above the main section, especially when you have a lot of functions and definitions at the top.


### Quoting

* Do put quotes around variables and strings because it makes them stand out a little and clarifies your intent.
    * Unless it gets too cluttered.
    * Or they need to be unquoted for expansion.
* Don't quote integers.
* Use single quotes unless interpolation is required.
* Don't use `${var}` unless needed; it's too cluttered.
    * But that _is_ needed sometimes, like `${variable}_suffix` or `${being_lower_cased,,}`.
* Do quote command substitutions, like `var="$(command)"`.
* _Always_ quote both sides of any test statement, like `[[ "$foo" == 'bar' ]]`.
    * Unless one side is an integer.
    * And unless you are using `=~`, in which case you can't quote the regular expression!
* Consider single-quoting variables inside `echo` statements, like `` echo "cd to '$DIR' failed." `` because it's visible when a variable is unexpectedly undefined or empty.
    * Or `echo "cd to [$DIR] failed."` as you like.
    * If using `set -u`, you will get an error if the variable is not defined—but not if it is defined but is just unexpectedly empty.
* Prefer single quotes around `printf` formats (see "POSIX output" in chapter 6 of _bash Idioms_ and the rest of chapter 6 in general).


### Layout

* Line things up! Multiple spaces almost never matter in bash (except around `=`), and lining up similar commands makes it easier to read and to see both the similarities and differences.
* _Do not allow trailing white space!_ This will later cause noise in the VCS (version control system) when removed.
* Indent using four spaces, but use TAB with here-documents as needed.
* Break long lines at around 78 columns, indent line continuations two spaces, and break just before `|` or `>` so those parts jump out as you scan down the code.
* The code to open a block goes on one line, like:
    * `if expression; then`
    * `for expression; do`
* List elements in `case..esac` are indented four spaces, and closing `;;` are at that same indent level. Blocks for each item are also indented four spaces.
    * One-line elements should be closed with `;;` on the same line.
    * Prefer lining up the `)` in each element, unless it gets cluttered or out of hand.
    * See the example code in [parselonghelp.sh](https://github.com/vossenjp/bashidioms-examples/tree/master/ch08/parselonghelp.sh).


### Syntax

* Use `#!/bin/bash -` or `#!/usr/bin/env bash` when writing bash code, not `#!/bin/sh`.
* Use `$@` unless you are _really_ sure you need `$*`.
* Use `==` instead of `=` for equality, to reduce confusion with assignment.
* Use `$(...)` instead of `` `...` `` backticks/backquotes.
* Use `[[` instead of `[` (unless you need `[` for portability, e.g., `dash`).
* Use `((...))` and `$((...))` as needed for integer arithmetic; avoid `let` and `expr`.
* Use `[[ expression ]] && block` or `[[ expression ]] || block` when it is simple and readable to do so. Do not use `[[ expression ]] && block || block` because that doesn't do what you think it does; use `if .. then .. (elif ..) else .. fi` for that.
* Consider using "Unofficial bash Strict Mode" (see "Unofficial bash Strict Mode" in chapter 9 of _bash Idioms_).
    * `set -euo pipefail` will prevent or unmask many simple errors.
    * Watch out for this one, and use it carefully (if you use it at all): `IFS=$'\n\t'`.


### Other

* For "system" scripts, log to syslog and let the OS worry about final destination(s), log rotation, etc.
* Error messages should go to STDERR, like `echo 'A Bad Thing happened' 1>&2`.
* Sanity-check that external tools are available using `[ -x '/path/to/tool' ] || { ...error code block... }`.
* Provide useful messages when things fail.
* Set `exit` codes, especially when you fail.


### Script Template

~~~~ {.bash}
#!/bin/bash -
# Or possibly: #!/usr/bin/env bash
# <Name>: <description>
# Original Author & date:
# Current maintainer?
# Copyright/License?
# Where this code belongs?  (Hosts, paths, etc.)
# Project/repo?
# Caveats/gotchas?
# Usage?  (Better to have `-h` and/or `--help` options!)
# $URL$  # If using SVN
ID=''    # If using SVN
#_________________________________________________________________________
PROGRAM=${0##*/}  # bash version of `basename`

# Unofficial bash Strict Mode?
#set -euo pipefail
### CAREFUL: IFS=$'\n\t'

# GLOBAL and constant variables are in UPPER case
LOG_DIR='/path/to/log/dir'

### Consider adding argument handling to YOUR template; see:
# examples/ch08/parseit.sh
# examples/ch08/parselong.sh
# examples/ch08/parselonghelp.sh

# Functions are in Mixed Case
###########################################################################
# Define functions

#--------------------------------------------------------------------------
# Example function
# Globals: none
# Input:   nothing
# Output:  nothing
function Foo {
    local var1="$1"
    ...
} # End of function foo


#--------------------------------------------------------------------------
# Another example function
# Globals: none
# Input:   nothing
# Output:  nothing
function Bar {
    local var1="$1"
    ...
} # End of function bar


###########################################################################
# Main

# Code...
~~~~
