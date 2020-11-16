# Mailpile tutorial
*Mailpile* post-installation tutorial

**URL to the tutorial deployed online: [https://greenpark-code.github.io/Mailpile_tutorial/](https://greenpark-code.github.io/Mailpile_tutorial/)**

Relative link to the tutorial in html format: [docs/index.html](docs/index.html)

## Requirements to build:

- **perl** (v5.26.1 here at the moment)
- **bash** (version 4.4.20(1) here at the moment).
- **pandoc** (ver. 1.19.2.4 here at the moment)
- **md_footnotes.pl** already included in this repository (ver. 1.1 here at the moment, please notice that there's no real options handling).  
  It's a Perl pre-processor that I've made quickly to handle footnotes the way I like, with the resulting html syntax similar to pandoc's one (while I was on it, I made it so it **allows nested footnotes**, after reading [here](https://github.com/jgm/pandoc/issues/2053)).  
  I have been keeping it in a folder included in my PATH, but for this repository **I'm copying it directly into the src/ subfolder** (I might later create a code snipset or a repository)

## How to build the html file

    cd src
    ./build.sh

## Acknowledgments

The stylesheet the build is using at the moment, MIT license: [https://gist.github.com/Dashed/6714393](https://gist.github.com/Dashed/6714393)

The only difference I've applied since grabbing it from GitHub:

    --- github-pandoc.css-orig	2020-04-30 23:47:18.132818175 -0300
    +++ overallstyle.css	2020-11-15 13:32:34.347465715 -0300
    @@ -213,7 +213,7 @@
     }
     
     sup {
    -    top: -0.5em;
    +    top: -0.25em;
     }
     
     sub {


<br>

-----

<br>

## Marginal notes

### Why many separate markdown files

Markdown files are not grabbed in their ls sort order, a numeric order is followed for each of the mailpile__img_*.md files (hence a missing file would generate
an error). Each one of the additional files is picked by name.


The TOC is automatically generated.


Why separate parts?

To be able to easily change how images get assembled with the rest (not valid for image 16b, image 16c, image 60b).
To be able to keep at hand specific parts more easily than having split views in the editor.


Of course, in a bash terminal window, if you want to search which files contain a string:

grep -il "string" *.md

or

grep -Eil "regexp" *.md


To edit all matching files:

myeditor `grep -il "string" *.md`

or

myeditor `grep -Eil "regexp" *.md`

-----

### Two build scripts, you shouldn't need the currently unused one

There are two build scripts, a remark at the beginning explains the difference.

Except for the possibility or not to put footnotes into aaa__A__mainTitle.md and for the necessity to rebuild twice if the TOC changes,
they have been giving the same identical final html file.

