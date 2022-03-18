#!/usr/bin/env bash
# embedded-docs.sh: Example of bash code with various kinds of embedded docs
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch10/embedded-docs.sh
#_________________________________________________________________________
# Does not work on Zsh 5.4.2!

[[ "$1" == '--emit-docs' ]] && {
    # Use the Perl "range" operator to print only the lines BETWEEN the bash
    # here-document "DOCS" markers, excluding when we talk about this code
    # below in the docs themselves.  See the output for more.
    perl -ne "s/^\t+//; print if m/DOCS'?\$/ .. m/^\s*'?DOCS'?\$/ \
      and not m/DOCS'?$/;" $0
    exit 0
}

echo 'Code, code, code... <2>'
echo 'Code, code, code...'
: << 'DOCS'
=== Docs for My Script <7>

Ignore the callout in this title; it only makes sense in the output later.

Docs can be Markdown, AsciiDoc, Textile, whatever.  This block is generic markup.

We've wrapped them using the no-op ':' operator and a here-doc, but you
have to remember, it's not bash that's processing the here-docs, so using
<<-DOC for indenting will not work.  Not quoting your marker will not allow
variable interpolation either, or rather, it will, but that won't affect your
documentation output.  So always quote your here-doc marker so your docs do
not interfere with your script (e.g., via the backticks we'll use below).

All of your docs could be grouped near the top of the file, like this,
for discoverability.  Or they could all be at the bottom, to stay grouped
but out of the way of the code.  Or they could be interspersed to stay near
the relevant code.  Do whatever makes sense to you and your team.

DOCS
echo 'More code, code, code... <3>'
echo 'More code, code, code...'
: << 'DOCS'
=head1 POD Example <8>

Ignore the callout in this title; it only makes sense in the output later.

This block is Perl POD (Plain Old Documentation).

If you use POD, you can then use `perldoc` and the various `pod2*` tools,
like `pod2html`, that handle that.  But you can't indent if using POD, or
Perl won't see the markup, unless you preprocess the indent away before
feeding the POD tools.

And don't forget the `=cut` line!

=cut

DOCS
echo 'Still more code, code, code... <4>'
echo 'Still more code, code, code...'
: << 'DOCS'
	Emitting Documentation <9>
	----------------------

	Ignore the callout in this title; it only makes sense in the output later.

	This could be POD or markup, whatever.

	This section uses a TAB indented here-doc, just because we can, but we
	handle that in the Perl post processor, not via bash. :-/

	You should add a "handler" to your argument processing/help options to emit
	your docs.  If you use POD, use those tools, but make sure they are installed!
	If you use some other markup, you have to extract it yourself somehow.

	We know this is a bash book, but this Perl one-liner using regular
	expressions and the range operator is really handy:
	    perl -ne "s/^\t+//; print if m/DOCS'?\$/ .. m/^\s*'?DOCS'?\$/ \
	      and not m/DOCS'?$/;" $0

	That will start printing lines when it matches the regular expression
	m/DOCS'?$/, and stop printing when it matches m/^\s*'?DOCS'?\$/, except that
	it won't print the actual line containing m/DOCS/ at all.

	Add that to your argument processing as "emit documentation."

DOCS

echo 'End of code... <5>'

exit 0  # Unless we already exited >0 above

: << 'DOCS'
h2. More Docs AFTER the code <10>

Ignore the callout in this title; it only makes sense in the output later.

This block is back to generic markup.  We do *not* recommend mixing and
matching like we've done here!  Pick a markup and some tools and stick to
them.  If in doubt, GitHub has made Markdown _very_ popular.

Docs can just go *after* the end of the code.  There's an argument for putting
all the docs together in one place at the top or bottom of the script.  This
makes the bottom easy.  On the other hand, there's an argument for keeping
the docs _close_ to the relevant code, especially for functions.  So...your call.

But if this section only has an `exit 0` above it and is not wrapped in a
bogo-here-doc, this might cause some syntax highlighters to be unhappy, and our
Perl doc emitter will miss it, so you have to find a different way to
display the docs.
DOCS
