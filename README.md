# bashidioms-examples

Welcome to the examples from O'Reilly's _bash Idioms_, by Carl Albing and JP Vossen.

* <https://www.oreilly.com/library/view/bash-idioms/9781492094746/>
* <https://www.amazon.com/bash-Idioms-Powerful-Flexible-Readable/dp/1492094757/>
* By the same authors, the _bash Cookbook_ (2nd edition)
    * <https://www.oreilly.com/library/view/bash-cookbook-2nd/9781491975329/>
    * <https://www.amazon.com/bash-Cookbook-Solutions-Examples-Cookbooks/dp/0596526784>
    * <https://github.com/vossenjp/bashcookbook-examples>
* Other bash resources <http://bashcookbook.com/>
    * <http://www.bashcookbook.com/bashinfo>

## Files

Each sub-directory contains the important, long, or difficult-to-type examples from the relevant chapter.

* `bcb2-appd.pdf` is appendix D of _bash Cookbook_ Second Edition (ISBN 978-1-491-97533-6), extracted here as a stand-alone document for ease of reference and to encourage using revisions control for your bash coding.
    * The current file *IS BROKEN* and just a placeholder until we get a good build from production!
* `appa\` is the "Bash Idioms Style Guide" from chapter 11, but without the commentary and discussion:
    * HTML version: `bash_idioms_style_guide.html`.
    * Markdown version: `bash_idioms_style_guide.md`.
        * <https://github.com/vossenjp/bashidioms-examples/blob/main/appa/bash_idioms_style_guide.md>
* `template.sh` is a sample boilerplate or template script to copy when creating a new script.
* `ch*\` examples from chapters:
    * `*.sh` is the actual bash code.
    * `*.out` in some cases, is the output as included in the book.
    * `ch10/ssh_config` is the sample SSH config file to create a menu used in `ch10/select-ssh.sh` and dome debugging
