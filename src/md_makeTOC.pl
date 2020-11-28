#!/usr/bin/perl

# Gets all Markdown title lines # ... or ## ... or ### ... etc.
# parse backwards looking for <a name="label">
# produces Table Of Contents in Markdown format.


# Usage:
# 
# cat myTutorialAllInOneFile_afterProcessingFootnotes.md | ./makeTOC.pl > toc.md
#
# After processing footnotes if you want the NOTES title appear in the TOC (see md_footnotes.pl and the remark about "#### NOTES" or "# NOTES").


# TO-DO: add a hash of labels and warn in case of repeated label.
# possibly TO-DO: option not to keep all lines in memory but at most $expectedMaxDistance lines and in case change the message to "... not found within...".

# NOTE: if you don't put a <a name="someLabel"> anchor on the first title, you'll get a warning, no problem just edit the resulting TOC according to your needs.


use strict;
use warnings;

my ($omitFirstTitle_CLparam) = @ARGV;

# --------------------------------------
# TO-DO: add proper opts handling and make these two as well command line parameters
my $expectedMaxDistance = 4; # lines, backwards
my $verbose = 0; # boolean
# --------------------------------------
my $omitFirstTitle = 0; # boolean

if ($omitFirstTitle_CLparam) {
    if ($omitFirstTitle_CLparam eq "-F") {
        $omitFirstTitle = 1; # boolean
        print STDERR "md_makeTOC.pl will omit the first title, given the -F command line parameter.\n";
    }
    elsif ($omitFirstTitle_CLparam ne "") { # "else {" would be enough, as already tested above "if ($omitFirstTitle_CLparam) { ..."
        print STDERR "Usage: md_makeTOC.pl [-F]\n";
        print STDERR "       -F: omit first title (default: does not omit)\n";
        exit 1;
    }
}
# --------------------------------------


my $terCols = `tput cols`;
# printf STDERR "Terminal columns: %d\n", $terCols;
my $separ="";
for (my $i = $terCols-1; $i > 0; $i--) {
    $separ .= "-";
}


my @lines;
my $thisLineIndex = -1;

# Parallel TOC vectors.
my @titles_contents;
my @titles_levels;
my @titles_labels;

my $levelIndent = "    ";

# To check and warn about reused labels.
my %label_lineIndexWhereItWasMet;
my %label_indexWhereStoredInTOCvectors;

my $anyWarningIssued = 0; # boolean
my $firstTitlePassed = 0; # boolean

sub indent {
    my ($level) = @_;
    for (my $count = $level-1; $count > 0; $count--) {
        # 0 indent for level 1
        print "$levelIndent";
    }
}


while (<STDIN>) {
    $thisLineIndex++;
    my $thisLine = $_;
    push(@lines, $_);
    
    if (/^([#]+)\s+(.*)$/) {
        if ($firstTitlePassed || !$omitFirstTitle) {
            my $level = length($1);
            my $content = $2;
            push(@titles_levels, $level);
            push(@titles_contents, $content);
        
            # Search in previous lines for
            # <a name="label">
        
            my $found = 0; # could actually be a boolean
            my $backwardScanIndex = $thisLineIndex-1;
        
            while ($found == 0 && $backwardScanIndex >= 0) {
                if ($lines[$backwardScanIndex] =~ /<a name="([^"]+)">/) {
                    $found++;
                    my $thisLabel = $1;
                    push(@titles_labels, $thisLabel);
        
                    # Check label not previously used.
                    my $lineIndexWhereLabelPreviouslyMet = $label_lineIndexWhereItWasMet{lc($thisLabel)};
                    if ($lineIndexWhereLabelPreviouslyMet) {
                        my $indexInTOCvectors = $label_indexWhereStoredInTOCvectors{lc($thisLabel)};
                        # Label already used in a previous line.

                        print  STDERR "$separ\n";
                        printf STDERR "WARNING: <a name=\"...\">  **** LABEL USED BEFORE **** | line number %5d - level %2d - label: %s - title: %s\n", ($thisLineIndex+1), $level, $thisLabel, $content;
                        printf STDERR "         The same label was used here:               | line number %5d - level %2d - label: %s - title: %s\n", ($lineIndexWhereLabelPreviouslyMet+1), $titles_levels[$indexInTOCvectors], $titles_labels[$indexInTOCvectors], $titles_contents[$indexInTOCvectors];
                        print  STDERR "\n";
                        printf STDERR "         ONLY THE FIRST OCCURRENCE WILL BE REACHABLE BY CLICKING ON THE TOC (match is CASE INSENSITIVE)\n";
                        $anyWarningIssued = 1; # boolean
                    }
                    else {
                        # OK, label not previously used.
                        $label_lineIndexWhereItWasMet{lc($thisLabel)} = $thisLineIndex;
                        $label_indexWhereStoredInTOCvectors{lc($thisLabel)} = scalar(@titles_labels)-1;
                    }
                }
                else {
                    $backwardScanIndex--;
                }
            }
            if ($found == 0) {
                push(@titles_labels, "");
                print  STDERR "$separ\n";
                printf STDERR "WARNING: <a name=\"...\"> not found scanning backwards | line number %5d - level %2d - title: %s\n", ($thisLineIndex+1), $level, $content;
                # printf STDERR "Line number %d - level %d - title: %s\n", ($thisLineIndex+1), $level, $content;
                $anyWarningIssued = 1; # boolean
            }
            elsif ($thisLineIndex - $backwardScanIndex > $expectedMaxDistance) {
                # warns if found more than n lines backwards
                print  STDERR "$separ\n";
                printf STDERR "WARNING: <a name=\"...\"> found %6d lines backwards | line number %5d - level %d - title: %s\n", ($thisLineIndex - $backwardScanIndex), ($thisLineIndex+1), $level, $content;
                $anyWarningIssued = 1; # boolean
            }
        }
        $firstTitlePassed = 1; # boolean
    }
}

if ($anyWarningIssued) {
    print  STDERR "$separ\n";
}

printf STDERR "Processed %d lines\n", $thisLineIndex+1;

my $lengthResults = scalar(@titles_contents);

for (my $scanResults = 0; $scanResults < $lengthResults; $scanResults++) {
    my $outputLabel = $titles_labels[$scanResults];
    if ($verbose) {
        printf STDERR "Level: %2d - Label: %s - Content: %s\n", $titles_levels[$scanResults], $outputLabel, $titles_contents[$scanResults];
    }
    if ($outputLabel ne "__footnotes__") {
        indent($titles_levels[$scanResults]);
    }
    printf "- [**%s**](#%s)\n", $titles_contents[$scanResults], $titles_labels[$scanResults];
}

