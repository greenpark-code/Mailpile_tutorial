#!/usr/bin/perl

# ver 1.1

# SYNTAX 
# this needs a footnote[^anyLabelYouLike]
# <optional empty line(s)>
# [^anyLabelYouLike] This is the footnote. Can contain formatted paragraphs. TO-DO: improve this note.
# ^ This '[' parenthesis must be the first character of the line, there should not be # on the first column, it's necessary here to make the line a remark.
# <at least one empty line, meaning not even space or tab characters>
#
# This is another example[^anotherOne], tested (delete '# ' from the left).
# 
# [^anotherOne] This footnote starts here.  
#     Four spaces indentation.
#     - can contain
#     - lists
#       - nested
#       - sublists
#     
#     Empty lines (indented 4 characters).
#
# You can put a footnote mark inside a footnote.
#
# NOTICE: to put quoted text in a footnote, indent by 4 spaces before '>' characters. Indenting e.g. by three characters => pandoc (ver 1.19.2.4) would keep quoting,
#         all successive footnotes would appear to be within that quote.
#
# NOTICE: apparently pandoc won't let you put two anchors one immediately after another, it suppresses the second one. So, if you need to put an anchor
# at the beginning of a note (beside the automatically numbered one), you'll have to put it after at least one word. (This script is not the origin of the problem.)
#
# NOTICE: do not end a footnote with a block code, put at least one text line which would go to output past the block code,
# even only containing &nbsp; so the "back to marker in main text" link can be placed correctly.


# Apparently working fine on Perl v5.26.1 "built for x86_64-linux-gnu-thread-multi (with 67 registered patches, see perl -V for more detail)"
# THIS IS ACTUALLY ABOUT ENDNOTES, NOT FOOTNOTES, WHICH MEANS NOTES CONTENTS ARE ALL PUT AT THE END OF THE DOCUMENT.
# Making this for this Manifesto: https://github.com/ParadigmaNuovo/Manifesto/blob/master/README.md
#
# I was going to make a Perl pre-processor to handle footnotes and still give a MarkDown output, and decided to add the possibility of notes in notes
# after seeing this thread https://github.com/jgm/pandoc/issues/2053 (yep :D "the abomination").


use strict;
use warnings;

my $squareBracketsForNoteMarks = 1;     # boolean
my $squareBracketsArePartOfTheLink = 0; # boolean

my $printRemarkToDocumentIfMissingNoteContent = 1; # boolean
my $putTwoTrailingSpacesOnEachLineEndingWhileGatheringNoteContent = 0; # boolean # I prefer to handle it manually.
my $suppress1stNonNoteContentLineIfEmpty = 1; # boolean # Allows to define notes contents in the middle of text which needs to _continue_ indented,
                                                        # e.g. bullet/numbered lists, and in general avoids leaving one more empty line per note content defined.

my $outputEmptyLineAfterNoteContent = 1; # boolean
# This has nothing to do with the previous option, this is not about main text output, it allows to have more airy/tidy output of notes contents.
# NOTICE: apparently, pandoc's render is not respecting that empty line IF it is also the end of a dotted list. I don't find a workaround ATM, except of course
#         avoiding to end the note content with a dotted list. I'll see how GitHub's render goes.
#         EDIT: found workaround which doesn't give excessive spacing, printing <p></p>, works with both approaches, empty line before OR after note content. 
my $outputEmptyLineBeforeNoteContent = 0;

my $separatorBeforeNotes = '';


# ---------------- before adding anchor to footnotes title ----------------
# if ($outputEmptyLineBeforeNoteContent) {
#     $separatorBeforeNotes = "<br>\n---\n\n---\n\n---\n\n#### NOTES\n\n\n"; # "note" would be the the Italian plural for singular nota. TO-DO: plural/singular according to number of notes? :/
# }
# else {
#     $separatorBeforeNotes = "<br>\n\n---\n\n---\n\n---\n\n#### NOTES\n\n\n"; # "notes" would be the Italian plural for singular nota. TO-DO: plural/singular according to number of notes? :/
# }
# -------------------------------------------------------------------------

# NOTICE: md_makeTOC.pl will treat __footnotes__ as a special label, no indent despite "#### NOTES" being a smaller (lower level) title than "# NOTES".

if ($outputEmptyLineBeforeNoteContent) {
    $separatorBeforeNotes = "<br>\n---\n\n---\n\n---\n\n<a name=\"__footnotes__\"></a>\n\n#### NOTES\n\n\n"; # "note" would be the the Italian plural for singular nota. TO-DO: plural/singular according to number of notes? :/
}
else {
    $separatorBeforeNotes = "<br>\n\n---\n\n---\n\n---\n\n<a name=\"__footnotes__\"></a>\n\n#### NOTES\n\n\n"; # "notes" would be the Italian plural for singular nota. TO-DO: plural/singular according to number of notes? :/
}

my $insertBeforeLinkToReturnFromNote = "&nbsp;"; # or = '' if you want the "back from note" arrow to be glued aside the last workd in the note.


# THE ALGORITHM IS POSSIBLY UNNECESSARILY COMPLICATED, see below "match from left to right", I'm not an expert in Perl or regex, searching the web didn't quickly
# provide a way to have that regex match from left to right, and I wanted this thing _done_ ASAP without having to put questions in forums and wait for answers.

# Input:  Markdown text with footnotes as described in Markdown extensions: https://www.markdownguide.org/extended-syntax
# Output: Markdown text with endnotes already translated into html.

# NESTED NOTES ARE ALLOWED BUT NOT THE POSITIONING OF THE DEFINITIONS OF NOTES CONTENTS, ALL OF THEM MUST START AT COLUMN 1, SUCCESSIVE LINES PART OF THE SAME
# NOTE CONTENT MUST BE INDENTED, THE FIRST LINE ENCOUNTERED WHICH STARTS AT COLUMN 1 WILL BE TAKEN AS SOMETHING ELSE (normal text or the beginning of the
# definition of the content of another note).

# DEFINITIONS OF NOTES CONTENT ARE MORE READABLE IF PRECEDED AND FOLLOWED BY AN EMPTY LINE, BUT THAT IS NOT NECESSARY.
# The script actually leaves those empty lines in the main text if the content definition is put _inside_ the main text, UNLESS you leave the option
# $suppress1stNonNoteContentLineIfEmpty set to 1 as it is by default. 
# The empty line would be no problem in Markdown, which html render wouldn't take that extra empty line into account, BUT NOT LEAVING the empty line allows to write
# notes contents definitions inside e.g. a dotted list or a quote, without having to postpone till the end of a possibly very long dotted list or quote.

# OF COURSE, "VISUALLY EMPTY" LINES BEFORE AND AFTER THE DEFINITIONS OF NOTES CONTENTS COULD ALSO NOT BE EMPTY BUT CARRY INDENTATION SPACES, if that text area
# needs to "stay indented" (beware how those lines will be taken into account in the html render).
# (AGAIN: a note content definition ends with the first empty line or not indented line.)

# NUMERATION OF NOTES FOLLOWS THEIR APPEARANCE ORDER, THUS, NUMERATION OF NOTES INSIDE NOTES DEPENDS ON WHERE EACH NOTE CONTENT IS DEFINED.
# TO US, IT'S LOGIC AND COMFORTABLE TO DEFINE A NOTE CONTENT AS SOON AS IT IS POSSIBLE TO GO BACK TO COLUMN 1, NO INDENTATION, AND THAT CRITERIA GIVES
# PROGRESSIVE NOTES NUMBERING, MEANING THAT THE FIRST NOTE PUT INSIDE NOTE <N> WOULD BECOME NOTE <N+1>. NOT SO IF THE DEFINITION OF THE CONTENT OF NOTE N
# (and with it the mark of the nested note) IS LEFT FOR LATER AND APPEARS AFTER OTHER NOTES MARKS WHICH WILL BE ASSIGNED NUMBERS STARTING WITH N+1.


my $numLine = 0;

# Notes content can appear at the beginning of any line _after_ the respective label, it will be put at the bottom.
# Notes CAN be nested but NOT the definitions of their contents (it might make too complex to distinguish indent reasons, let's keept it simpler)
my $gatheringNote = 0; # boolean; could omit this variable and directly test one of the following vars as well, an empty string tests as false in Perl
my $gatheringNote_label = '';
my $gatheringNote_content = '';

# ----------------------------------------------------------------- 
# ----- This is the goal of the whole scan of the input text. -----
my @notesLabelsMarksInOrder;

# TO-DO: MIGHT LEARN HOW TO STORE ARRAYS AS HASH VALUES, instead of having various hash lists with the same keys, e.g. https://www.caveofprogramming.com/perl-tutorial/perl-array-of-array.html
# But this is not a priority at all vs. what I'm doing with this script which is already surprisingly fast anyway.
my %notesLabelsMarksLines;
my %notesLabelsMarksCols;
my %notesMarksWillBeAssignedTheseNumbers;
my %notesContents;

my $currentMarkNumber = 0;  # Can't wait to gather them all, that would imply making two passes of the document, output in the 2nd pass.
                            # By making one single pass, however, we'll have jumps in end notes numbering if contents for any of them are MISSING,
                            # which is a CORRECT principle anyway, they should NOT be missing.
# ----------------------------------------------------------------- 


my @labelsFoundOnThisLine; # array of arrays column, label
my @respectiveColNumbers;


# NOTE: I've searched the web, I don't find how to have this regex match from left to right, with which, what follows would be simpler.
#       It's actually matching right to left, but I don't want to assume that either, just in case other Perl implementations might match in some other order, which is
#       why I'm adding a sort by column number of the two "parallel vectors" @labelsFoundOnThisLine and @respectiveColNumbers (together they make an associative list).

# Match => calls itself recursively for the part of the line at the left of the matching text and for the part at the right of it.

sub parseLine_1stPass {
    my ($debuggingSayRecursionLevel, $incomingCol, $debuggingSayWhichPart, $incomingText) = @_;   # , @labelsFoundOnThisLine, @respectiveColNumbers
    # my $matched = 0; # boolean
    # printf "Rec.level %d, incoming col: %d, was %s, text: \"%s\"\n", $debuggingSayRecursionLevel, $incomingCol, $debuggingSayWhichPart, $incomingText;

  # if ($incomingText =~ /^(.*)\[\^([^]]+)\](.*+)$/) {  # NOPE, I'll include the delimiting square brackets in the label => EASIER to replace with html
    if ($incomingText =~ /^(.*)(\[\^[^]]+\])(.*+)$/) {
        # This is matching right to left, but I'll scan the vector @respectiveColNumbers from the end to beginning (or I could use unshift instead of push).
        # (NOT to rely on it ^, also added a bubble sort below, quicksort can be slower on already ordered sequences, if I remember correctly from long ago.)
        # print "bis \$incomingCol: $incomingCol\n";
        my $leftOfLabel = $1;
        my $label = $2;
        my $rightOfLabel = $3;

        # printf "Linea %d - found md note label: >%s<\n", $numLine, $label;
        # printf "Left of label: >%s<\n", $leftOfLabel;
        # printf "Right of label: >%s<\n\n", $rightOfLabel;

        my $lengthLeftPart = length($leftOfLabel);
        my $thisMatchCol = $incomingCol + $lengthLeftPart;
        
        # printf ">>>>>>>>>>>>>>> pushing %d, %s\n", $incomingCol + $lengthLeftPart, $label;
        push(@labelsFoundOnThisLine, $label);
        push(@respectiveColNumbers, $thisMatchCol);
        # print "tris \$incomingCol: $incomingCol\n";
        
        # printf "\$incomingCol before recursive call for left part: %d\n", $incomingCol;
        if ($lengthLeftPart > 0) {
            parseLine_1stPass($debuggingSayRecursionLevel+1, $incomingCol, "left", $leftOfLabel);   # , @labelsFoundOnThisLine, @respectiveColNumbers
        }
        # printf "\$incomingCol after recursive call for left part, before call for right part: %d\n", $incomingCol;
        if (length($rightOfLabel) > 0) {
            parseLine_1stPass($debuggingSayRecursionLevel+1, $incomingCol + $lengthLeftPart + length($label)+3, "right", $rightOfLabel);   # , @labelsFoundOnThisLine, @respectiveColNumbers
        # printf "\$incomingCol after recursive call for right part: %d\n", $incomingCol;
        }
    # return $matched;
    return;
    }
}    


sub parseLine_2ndPass {
    my ($debuggingSayRecursionLevel, $incomingCol, $debuggingSayWhichPart, $incomingText, $numLine) = @_;   # , @labelsFoundOnThisLine, @respectiveColNumbers, %notesLabelsMarksLines, %notesMarksWillBeAssignedTheseNumbers
    my $returnText = '';
    # my $matched = 0; # boolean
    # printf "Rec.level %d, incoming col: %d, was %s, text: \"%s\"\n", $debuggingSayRecursionLevel, $incomingCol, $debuggingSayWhichPart, $incomingText;

  # if ($incomingText =~ /^(.*)\[\^([^]]+)\](.*+)$/) {  # NOPE, I'll include the delimiting square brackets in the label => EASIER to replace with html
    if ($incomingText =~ /^(.*)(\[\^[^]]+\])(.*+)$/) {
        # This is matching right to left, but I'll scan the vector @respectiveColNumbers from the end to beginning (or I could use unshift instead of push).
        # (NOT to rely on it ^, also added a bubble sort below, quicksort can be slower on already ordered sequences, if I remember correctly from long ago.)
        # print "bis \$incomingCol: $incomingCol\n";
        my $leftOfLabel = $1;
        my $label = $2;
        my $rightOfLabel = $3;

        my $returnText_left = '';
        my $returnText_replaced = '';
        my $returnText_right = '';

        # printf "Linea %d - found md note label: >%s<\n", $numLine, $label;
        # printf "Left of label: >%s<\n", $leftOfLabel;
        # printf "Right of label: >%s<\n\n", $rightOfLabel;

        my $lengthLeftPart = length($leftOfLabel);
        my $thisMatchCol = $incomingCol + $lengthLeftPart;
        
        # # printf ">>>>>>>>>>>>>>> pushing %d, %s\n", $incomingCol + $lengthLeftPart, $label;
        # push(@labelsFoundOnThisLine, $label);
        # push(@respectiveColNumbers, $thisMatchCol);
        # # print "tris \$incomingCol: $incomingCol\n";
        
        my $labelPreviouslyMetInLineNum = $notesLabelsMarksLines{$label};
        my $labelPreviouslyMetInColNum = $notesLabelsMarksCols{$label};
        if ($labelPreviouslyMetInLineNum && $labelPreviouslyMetInLineNum == $numLine && $labelPreviouslyMetInColNum && $labelPreviouslyMetInColNum == $thisMatchCol) {
        
            # +++++++++++ TEST IF SAME COL NUMBER, COULD BE A REPEATED LABEL WHICH WAS IGNORED IN THIS POINT OF THE LINE (WELL, OMITTING THE TEST WOULD IMPLY OMITTING THE OTHER OCCURRENCE(S)... IT'S ARBITRARY ANYWAY, WE ARE CURRENTLY TAKING THE RIGHTMOST OCCURRENCE, BUT HEY THE WARNING MENTIONS THE COL NUMBER SO LET'S STICK TO IT)
        
            # checking same line number is overkill because we are warning and IGNORING repeated labels, precaution in case I'm missing something ATM
            # label previously met on this same line, not ignored => now REPLACING
            my $thisMarkNumber = $notesMarksWillBeAssignedTheseNumbers{$label};
            if ($squareBracketsForNoteMarks) {
                if ($squareBracketsArePartOfTheLink) {
                    $returnText_replaced = "<a href=\"#fn$thisMarkNumber\" id=\"fnref$thisMarkNumber\"><sup>[$thisMarkNumber]</sup></a>";
                }
                else {
                    $returnText_replaced = "<sup>[<a href=\"#fn$thisMarkNumber\" id=\"fnref$thisMarkNumber\">$thisMarkNumber</a>]</sup>";
                }
            }
            else {
                $returnText_replaced = "<a href=\"#fn$thisMarkNumber\" id=\"fnref$thisMarkNumber\"><sup>$thisMarkNumber</sup></a>";
            }
            
        }
        
        # printf "\$incomingCol before recursive call for left part: %d\n", $incomingCol;
        if ($lengthLeftPart > 0) {
            $returnText_left = parseLine_2ndPass($debuggingSayRecursionLevel+1, $incomingCol, "left", $leftOfLabel, $numLine);   # , @labelsFoundOnThisLine, @respectiveColNumbers, %notesLabelsMarksLines, %notesMarksWillBeAssignedTheseNumbers
        }
        # printf "\$incomingCol after recursive call for left part, before call for right part: %d\n", $incomingCol;
        if (length($rightOfLabel) > 0) {
            $returnText_right = parseLine_2ndPass($debuggingSayRecursionLevel+1, $incomingCol + $lengthLeftPart + length($label)+3, "right", $rightOfLabel, $numLine);   # , @labelsFoundOnThisLine, @respectiveColNumbers, %notesLabelsMarksLines, %notesMarksWillBeAssignedTheseNumbers
        # printf "\$incomingCol after recursive call for right part: %d\n", $incomingCol;
        }
        $returnText = $returnText_left . $returnText_replaced . $returnText_right;
    }
    else {
        $returnText = $incomingText;
    }
    return $returnText;
}    


while (<>) {
    $numLine++;
    my $thisLine = $_;
    my $thisLineIsTheBeginningOfANoteContentDefinition = 0; # boolean

    # Declared out of this scope, simply passing it along the recursion levels is not working
    # my @labelsFoundOnThisLine; # array of arrays column, label

    @labelsFoundOnThisLine = (); 
    @respectiveColNumbers = ();
    
    # On a same line there could be more than one note mark.
    parseLine_1stPass(0, 1, "start", $thisLine);   # , @labelsFoundOnThisLine, @respectiveColNumbers
    
    my $arrayLength = scalar(@labelsFoundOnThisLine);
    
    if ($arrayLength > 0) {
        # printf "line num. %d, array length: %d\n", $numLine, $arrayLength;
        # for (my $i = 0; $i < $arrayLength; $i++) {
        
        
        # Now going to scan the vector from the end to the beginning because the regexp match above was happenign right to left.

        # ANYWAY, in order to avoid any chance that peculiar Perl implementations might NOT match right to left the regexp above,
        # we add here a parallel sort of the two parallel arrays, ordering by col number.
                
        {   # SORT in decrescent order (fastest because it's what we are having here due to the regex above being matched right to left)
            my $lengthMinus2 = scalar(@labelsFoundOnThisLine)-2; # or $lengthMinus2 = $#labelsFoundOnThisLine-1;
            for (my $k = $lengthMinus2; $k >= 0; $k--) {
                for (my $j = 0; $j <= $k; $j++) {
                    if ($respectiveColNumbers[$j] < $respectiveColNumbers[$j+1]) {
                        
                        my $swapColNumbers = $respectiveColNumbers[$j+1];
                        $respectiveColNumbers[$j+1] = $respectiveColNumbers[$j];
                        $respectiveColNumbers[$j] = $swapColNumbers;
                        
                        my $swapLabels = $labelsFoundOnThisLine[$j+1];
                        $labelsFoundOnThisLine[$j+1] = $labelsFoundOnThisLine[$j];
                        $labelsFoundOnThisLine[$j] = $swapColNumbers;
                    }
                }
            }
            
        }
        
        
        
        for (my $i = $arrayLength-1; $i >= 0; $i--) {
            # printf "col: %d, text \"%s\"\n", $respectiveColNumbers[$i], $labelsFoundOnThisLine[$i];
            my $label = $labelsFoundOnThisLine[$i];
            my $colOfThisLabel = $respectiveColNumbers[$i];
          # my $previouslyDefinedNoteContent = $notesContents{$label};
            my $labelPreviouslyMetInLineNum = $notesLabelsMarksLines{$label};

            if ($colOfThisLabel == 1) {
                # This should be the beginning of the definition of a note content.
                if ($labelPreviouslyMetInLineNum) {
                    # It is actually the beginning of the definition of a note content.
                    $thisLineIsTheBeginningOfANoteContentDefinition = 1; # boolean

                    if ($gatheringNote) {
                        # close previous note content definition
                        $notesContents{$gatheringNote_label} = $gatheringNote_content;
                    }
                    else {
                        $gatheringNote = 1; # boolean
                    }
                    $gatheringNote_label = $label;

                    # NOTHING MORE HERE, SEE BELOW, AFTER PARSE LINE 2ND PASS
                    # my $thisLineNoLabel = substr($thisLine, length($label)); # Remove the label before the note content (possible further occurrences will remain in the output document and tell the user, already warned, that this needs to be fixed)
                    # # trim leading spaces
                    # $thisLineNoLabel =~ s/^\s+//;
                    # $gatheringNote_content = $thisLineNoLabel;
                }
                else {
                    # Warn.
                    print STDERR "*** WARNING *** Line $numLine col 1 seems to be the beginning of the content of a note which label \"$label\" was NOT previously encountered. Treating as a note mark label instead.\n";
                    # to-do: | fold -s -w `tput cols` | STDERR
                    push(@notesLabelsMarksInOrder, $label);
                    $notesLabelsMarksLines{$label} = $numLine;
                    $notesLabelsMarksCols{$label} = $colOfThisLabel;
                    $notesMarksWillBeAssignedTheseNumbers{$label} = ++$currentMarkNumber;
                }
            }
            else {
                if ($labelPreviouslyMetInLineNum) {
                    print STDERR "*** WARNING *** Line $numLine col $colOfThisLabel defines note label \"$label \"which has ALREADY been met before in line $labelPreviouslyMetInLineNum. IGNORING.\n";
                }
                else {
                    push(@notesLabelsMarksInOrder, $label);
                    $notesLabelsMarksLines{$label} = $numLine;
                    $notesLabelsMarksCols{$label} = $colOfThisLabel;
                    $notesMarksWillBeAssignedTheseNumbers{$label} = ++$currentMarkNumber;
                }
            }
        }

        # print STDERR "\n\nBefore 2nd pass: \"$thisLine\"\n";
        $thisLine = parseLine_2ndPass(0, 1, "start", $thisLine, $numLine) . "\n";   # , @labelsFoundOnThisLine, @respectiveColNumbers, %notesLabelsMarksLines, %notesMarksWillBeAssignedTheseNumbers
        # print STDERR "After 2nd pass: \"$thisLine\"\n\n";

        if ($thisLineIsTheBeginningOfANoteContentDefinition) {
            # my $thisLineNoLabel = substr($thisLine, length($gatheringNote_label)); # Remove the label before the note content (possible further occurrences will remain in the output document and tell the user, already warned, that this needs to be fixed)
            # trim leading spaces
            # $thisLineNoLabel =~ s/^\s+//;
            # $gatheringNote_content = $thisLineNoLabel;
            $gatheringNote_content = $thisLine =~ s/^\s+//r;
        }

    } # if ($arrayLength > 0)

    if ($gatheringNote) {
        if (!$thisLineIsTheBeginningOfANoteContentDefinition) {
            if (($thisLine =~ /^\S/) || ($thisLine =~ /^$/)) {
                # Close note content definition
                $notesContents{$gatheringNote_label} = $gatheringNote_content;
                $gatheringNote = 0; # boolean
                $gatheringNote_label = '';
                $gatheringNote_content = '';
                if ( !($suppress1stNonNoteContentLineIfEmpty && ($thisLine =~ /^$/)) ) {
                    # Send this line to output as normal text
                    print $thisLine;
                }
            }
            else {
                if ($putTwoTrailingSpacesOnEachLineEndingWhileGatheringNoteContent) {
                    $gatheringNote_content =~ s/\s*\n$/  \n/; # Two trailing spaces are the Markdown syntax to stay in the same paragraph despite going to a new line.
                    # (^ Could submit to test that $thisLine is not just spaces, but I'd say no, because
                    # absence of these two trailing spaces => end of paragraph anyway, better leave it to manual handling.)
                }
                $gatheringNote_content .= $thisLine;
            }
        }
    }
    else {
        print $thisLine;
    }
}


# ------------------------------------------------------------------------------------------------------------------------------------------------------
# Output of notes contents.

my $firstNoteToOutput = 1; # boolean

foreach(@notesLabelsMarksInOrder) {
    my $label = $_;
    my $previouslyDefinedNoteContent = $notesContents{$label};
    my $thisNoteAssignedNumber = $notesMarksWillBeAssignedTheseNumbers{$label};
    
    if ($firstNoteToOutput && ($previouslyDefinedNoteContent || $printRemarkToDocumentIfMissingNoteContent)) {
        print $separatorBeforeNotes;
        $firstNoteToOutput = 0; # boolean
    }
    if ($previouslyDefinedNoteContent || $printRemarkToDocumentIfMissingNoteContent) {
    
        if ($outputEmptyLineBeforeNoteContent) {
            print "<p></p>\n";
        }
        # output mark e.g.:
        # 1. <a id="fn1"></a>
        print "$thisNoteAssignedNumber. <a id=\"fn$thisNoteAssignedNumber\"></a>";
    }
    
    if ($previouslyDefinedNoteContent) {
        # output note content e.g.:
        # Si veda per esempio [*free-market anarchism*](https://en.wikipedia.org/wiki/Free-market_anarchism), e in [questa pagina](https://en.wikipedia.org/wiki/Laissez-faire) il termine *left-wing laissez-faire*.
        print $previouslyDefinedNoteContent =~ s/\s+$//r; # Trims trailing spaces including newline.
    }
    else {
        print STDERR "*** WARNING *** Missing note content for label \"$label\" encountered on line $notesLabelsMarksLines{$label} col $notesLabelsMarksCols{$label}.\n";
        if ($printRemarkToDocumentIfMissingNoteContent) {
            # output remark to catch the attention
            print "*** MISSING NOTE CONTENT *** for label \"$label\" encountered on line $notesLabelsMarksLines{$label} col $notesLabelsMarksCols{$label}.";
        }
    }
    if ($previouslyDefinedNoteContent || $printRemarkToDocumentIfMissingNoteContent) {
        # output link back, e.g.:
        # <a href="#fnref1">↩</a>
        print $insertBeforeLinkToReturnFromNote . "<a href=\"#fnref$thisNoteAssignedNumber\">↩</a>\n";
        if ($outputEmptyLineAfterNoteContent) {
            # print "    \n";
            print "<p></p>\n";
        }
    }
}

