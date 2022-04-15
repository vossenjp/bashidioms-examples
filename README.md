# _bash Idioms_ examples

<a href="http://www.bashcookbook.com/">
<img src="http://www.bashcookbook.com/images/idioms.png" width="226px" align="right" /></a>

Welcome to the examples from O'Reilly's _bash Idioms_, by Carl Albing and JP Vossen.

* <https://www.oreilly.com/library/view/bash-idioms/9781492094746/>
* <https://www.amazon.com/bash-Idioms-Powerful-Flexible-Readable/dp/1492094757/>
* By the same authors, the _bash Cookbook_ (2nd edition)
    * <https://www.oreilly.com/library/view/bash-cookbook-2nd/9781491975329/>
    * <https://www.amazon.com/bash-Cookbook-Solutions-Examples-Cookbooks/dp/0596526784>
    * <https://github.com/vossenjp/bashcookbook-examples>
* Other bash resources <http://bashcookbook.com/>
    * <http://www.bashcookbook.com/bashinfo>


## About the Book

Shell scripts are everywhere, especially those written in bash-compatible syntax. But these scripts can be complex and obscure. Complexity is the enemy of security, but it’s also the enemy of readability and understanding. With this practical book, you’ll learn how to decipher old bash code and write new code that’s as clear and readable as possible.

Authors Carl Albing and JP Vossen show you how to use the power and flexibility of the shell to your advantage. You may know enough bash to get by, but this book will take your skills from manageable to magnificent. Whether you use Linux, Unix, Windows, or a Mac, you’ll learn how to read and write scripts like an expert. Your future you will thank you. You’ll explore the clear idioms to use and obscure ones to avoid, so that you can:

* Write useful, flexible, and readable bash code with style
* Decode bash code such as `${MAKEMELC,,}` and `${PATHNAME##*/}`
* Save time and ensure consistency when automating tasks
* Discover how bash idioms can make your code clean and concise


## Example Files

Each sub-directory contains the important, long, or difficult-to-type examples from the relevant chapter.

* `bcb2-appd.pdf` is appendix D of _bash Cookbook_ Second Edition (ISBN 978-1-491-97533-6), extracted here as a stand-alone document for ease of reference and to encourage using revisions control for your bash coding.
* `appa\` is the "Bash Idioms Style Guide" from chapter 11, but without the commentary and discussion:
    * HTML version: `bash_idioms_style_guide.html`.
    * Markdown version: `bash_idioms_style_guide.md`.
        * <https://github.com/vossenjp/bashidioms-examples/blob/main/appa/bash_idioms_style_guide.md>
* `template.sh` is a sample boilerplate or template script to copy when creating a new script.
* `ch*\` examples from chapters:
    * `*.sh` is the actual bash code.
    * `*.out` in some cases, is the output as included in the book.
    * `ch10/ssh_config` is the sample SSH config file to create a menu used in `ch10/select-ssh.sh` and dome debugging
