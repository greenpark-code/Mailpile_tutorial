#!/bin/bash

# USE THIS BUILD SCRIPT UNLESS YOU NEED TO PUT FOOTNOTES IN PARTS PRECEDING THE TOC, ID EST IN mailpile__img_001__above.md

# This approach does NOT allow to put footnotes in aaa__A__mainTitle.md
# but it doesn't need to build twice when the TOC changes (it takes one second anyway).

set -e

# build in two steps, no need to build twice (that was taking 1 sec anyway) in case the TOC changes, BUT there is a drawback:
# aaa__A__mainTitle.md can not contain any footnotes (I may prefer to stick with the older build).

trailingBR=40
overallStylesheet="./overallstyle.css"

makeToc=true
tocFileName="aaa__B__toc.md"
keepMdIntermediates=false


if [ "$1" == "-k" ]
then
    keepMdIntermediates=true
elif [ "$1" != "" ]
then
    thisScript=`basename -- "$0"`
    echo "Usage: $thisScript [-k]"
    echo "       -k: keep intermediate assembled Markdown files"
    exit 1
fi


if ! [ -f "build_shouldBeRunFromWithinThisFolder.txt" ]
then
    thisScript=`basename -- "$0"`
    1>&2 echo "$thisScript should be run from within the folder containing all Markdown parts of the project. Aborting."
    exit 1
fi

mdFilename_stepA='Mailpile_basic_tutorial___beforePreprocessingFootnotes___WE_EDIT_PARTS_NOT_THIS_ONE.md' # all md files and pics, before footnotes preprocessing
mdFilename_stepB='Mailpile_basic_tutorial___afterPreprocessingFootnotes___WE_EDIT_PARTS_NOT_THIS_ONE.md'  # all md files and pics, before footnotes preprocessing
# htmlFilename='../docs/Mailpile_tutorial.html'
htmlFilename='../docs/index.html'


echo "Assembling Markdown past-TOC parts and images into first step Markdown file \"$mdFilename_stepA\"..."

bash ./_aux_doPackItAll_dontCallThisOneDirectly.sh -1 > "$mdFilename_stepA"

echo "Done."

echo "Calling footnotes preprocessor to write second step Markdown file \"$mdFilename_stepB\"..."

./md_footnotes.pl ${mdFilename_stepA} > "$mdFilename_stepB"
echo "Done."


if $makeToc
then
    echo "Building Table Of Contents \"$tocFileName\"..."

    # This approach doesn't need to keep the previous TOC.
    #
    # if [ -f "$tocFileName" ]
    # then
    #     mv "$tocFileName" "${tocFileName}_old.md"
    # fi

    # NOTICE: in md_makeTOC.pl this approach requires $omitFirstTitle = 0, no -F command line parameter
    cat "$mdFilename_stepB" | ./md_makeTOC.pl > "$tocFileName"
    echo "Done."
fi


echo "Assembling pre-TOC parts..."

mv "$mdFilename_stepB" "${mdFilename_stepB}.tmp" # a bit sloppy, I could introduce a third name above
bash ./_aux_doPackItAll_dontCallThisOneDirectly.sh -2 > "$mdFilename_stepB"
cat "${mdFilename_stepB}.tmp" >> "$mdFilename_stepB"
rm "$mdFilename_stepB.tmp"

echo "Done."

echo "Copying overall stylesheet and calling pandoc..."

echo "<style>" > "$htmlFilename"
cat "$overallStylesheet" >> "$htmlFilename" # keeping current permissions if it exists
echo "</style>" >> "$htmlFilename"
echo "" >> "$htmlFilename"

pandoc -r markdown -w html "$mdFilename_stepB" >> "$htmlFilename"
echo "" >> "$htmlFilename"
echo "" >> "$htmlFilename"
echo "Done."

if [ $trailingBR -gt 0 ]
then
    echo "Adding trailing empty lines..." 
    echo "" >> "$htmlFilename"
    # echo "<!--- trailing empty lines to allow your browser to position on the last footnotes --->" >> "$htmlFilename"

    for i in $(seq 1 $trailingBR)
    do
        echo -n "<br>" >> "$htmlFilename"
        if (($i % 8 == 0))
        then
            echo "<center><small>trailing empty lines to allow your browser to position with the last footnotes at the top of your screen</small></center>" >> "$htmlFilename"
        fi
    done
    echo "" >> "$htmlFilename"
    echo "Done."
fi


echo "Final product: \"$htmlFilename\""


if ! $keepMdIntermediates
then
    echo "Removing intermediate Markdown files..."
    echo -n "\"$mdFilename_stepA\"... "
    rm "$mdFilename_stepA"
    echo "removed."
    echo -n "\"$mdFilename_stepB\"... "
    rm "$mdFilename_stepB"
    echo "removed."
fi

    
# echo ""
# echo "Syncing disk..."
# sync
# echo "Done."

