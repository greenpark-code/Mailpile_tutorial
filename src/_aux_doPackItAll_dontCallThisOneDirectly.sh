#!/bin/bash

set -e

omitPart1=false
omitPart2=false

if [ "$1" == "-1" ]
then
    omitPart1=true
elif [ "$1" == "-2" ]
then
    omitPart2=true
elif [ "$1" != "" ]
then
    thisScript=`basename -- "$0"`
    echo "Usage: $thisScript [-1|-2]"
    echo "       -1: step 1, omit   files additionalstyle.css, aaa__A__mainTitle.md, and aaa__B__toc.md, which till be assembled after rebuilding the TOC from this output."
    echo "       -2: step 2, output files additionalstyle.css, aaa__A__mainTitle.md, and aaa__B__toc.md."
    echo "       default: old approach pre-automatic-TOC, output everything (but this approach would oblige to build twice when the TOC changes)"
    exit 1
fi


totNum=60
myStyle=true
debug=false
imgNums=true
center=false
separate=true

if ! $omitPart1
then
    if $myStyle
    then
        cat additionalstyle.css
    fi

    dateTimeNow=`date -u "+%Y-%m-%d %H:%M:%S UTC"`
    cat aaa__A__mainTitle.md | sed -- "s/__date_time__/$dateTimeNow/"
    if [ -f "aaa__B__toc.md" ]
    then
        cat aaa__B__toc.md
    fi
fi
# first=true


if ! $omitPart2
then
    for i in $(seq 1 $totNum)
    do
        # if $first
        #     then
        #     first=false
        #     echo "<br>"
        # fi

        padded=`printf "%03d" $i`

        if $debug
        then
            echo "<br>"
            echo "**${padded}**"
            echo "<br>"
        fi

        cat mailpile__img_${padded}__above.md
        echo ""

        if $center
        then
            echo "<center>"
        fi

        if $imgNums
        then
            echo "*image ${i}*  "
        fi
        echo "![img ${i}](pictures/mailpile__img_${padded}.jpg)"

        if $center
        then
            echo "</center>"
        fi
        echo ""

        cat mailpile__img_${padded}__below.md
        echo ""

        if $separate ; then echo "<br>" ; echo "-----" ; echo "<br>" ; fi # Before adding the appendix: if $separate && [ $i -lt $totNum ] ; then echo "<br>" ; echo "-----" ; echo "<br>" ; fi
    done
    cat zzz__A__CLItoSearchExportDelete_trash.md
    echo ""
    echo "<br>" ; echo "-----" ; echo "<br>"
    cat zzz__B__GnuPGexamples.md
    echo ""
fi
