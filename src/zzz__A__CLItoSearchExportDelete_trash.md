<a name="Mailpile_CLI"></a>
<big><span class="notEssent_CLI_bgnd_fg">This is not essential to use *Mailpile*</span></big>
<div class="notEssent_CLI_frame">

# The Command Line Interface (CLI) – not essential to use *Mailpile*

In *Mailpile*'s Command Line Interface (CLI), you can search for one or more words and then export or delete all the matching messages or some of them.

<a name="clearingTheCLI"></a>

## Clearing the CLI space

To get rid of previous output in the CLI:

<fixed>**ctrl-L**<fixed> (lowercase or uppercase L, just as in a bash shell)

<p class="fluo_green_frame">EACH ONE OF THE FOLLOWING COMMAND LINES HAS TO BE TERMINATED WITH THE \<ENTER\> KEY.</p>

<a name="GettingHelp"></a>

## Getting help, switching output format

Let's start by getting some help.  
To get help about the CLI commands (easier to read in text format than json format), just type the help command:

    help

If the output format is not plain text but something else, you can switch to text:

    output text

Should you need your results in json or html format, you can switch like this:
```
output json
```
```
output html
```

<span class="fluo_green_bgnd">**Don't forget how to switch back to text:**</span>

    output text

<a name="unwantedOutputFormatSwitch"></a>

<div class="fluo_orange_frame">
<a name="searchSideEffect"></a>**Sometimes, as an unwanted side effect of a search, my output got switched to json.** Switching back to text and repeating the same search was consistently having the same unwanted side effect. I guess the issue has been reported. <span class="fluo_orange_bgnd">**[needs clarification]**</span>

Sometimes, when that happened, after doing a search with zero matches (searching for a word I don't have in any emails), I could with no surprises launch the same search which had been triggering the unwanted output format change. Sometimes that didn't work, it was possibly a coincidence.</div>

<a name="SearchingExporting"></a>

## Searching, exporting emails

Before executing an `export` command, you need to execute a `search` one.  

To search:  
    search word another whatever

or:  
    s word another whatever

<div class="fluo_green_frame">*All* these words must be present *in one email* for a match to be triggered.  
The match is apparently case insensitive.</div>

In case any emails match your search, they'll appear in lines preceded by numbers.
To export them all into one text file:

    export all

Notice that `e` would be the shortcut for *another* command: Extract attachment(s) to file(s).


Here's what happens if I export the 2<sup>nd</sup>, 7<sup>th</sup>, 8<sup>th</sup> and 9<sup>th</sup> matching emails (the first line is my command):

```
export 2,7-9 <enter>
Elapsed: 0.208s (export: Exported 4 messages to mailpile-1602723517.mbx)

{
    "created": "mailpile-1602723517.mbx", 
    "exported": 4
}
```

**I find the resulting text file in my home folder.** Opening the file **~/mailpile-1602723517.mbx** and searching for "Subject: " confirms that it contains all those emails, although in different order.  
The help text mentions a few optional parameters to the export command that I haven't tried out yet.

To see all emails in the ***Reddit*** tag:  
    s in:reddit

**Result:**  
```
Elapsed: 0.002s (search: search)

  1   Reddit               "A more complex take on the b  (Important)22 hours
  2   Reddit              *"Hi, i tried to make a message with a one   Monday
  3   Reddit              *"[D] How do I encrypt and decrypt a messag  Sunday
  4   Reddit               "How to tell how an encrypted message wa  Saturday
  5   Reddit               "S/MIME SSL Question"                       Friday
  6   Reddit               "PLONK by Hand (Part 1: Setup)"           Thursday
  7   Reddit               "A Year and a Half of End-to-End Encryptio  Oct 06
  8   Reddit               "someone give me this code but i don't hav  Oct 05
  9   Reddit              *"I have a quite interesting code that a fr  Oct 04
 10   Reddit              *"What is the connection between stream cip  Oct 03
 11   Reddit               "ccrypt alternative for windows (without c  Oct 02
```

Let's search in the ***Reddit*** tag for something more specific:  
    s in:reddit encrypt

**Result:**  
```
Elapsed: 0.012s (search: Found 3 results in 0.012s)

  1   Reddit                  "ccrypt alternative for windows (without cygw..."  Oct 02
  2   Reddit                 *"[D] How do I encrypt and decrypt a message u..."  Sunday
  3   Reddit                  "A more complex take on the braille  (Important)Wednesday
```

Notice that the message which was result number 4 of the previous search didn't match now, searching for "encrypt" didn't match "encrypted":

<p class="fluo_green_frame">*Mailpile* is matching whole words.</p>

Wildcards do not seem to work, encrypt* doesn't match encrypted, I don't know yet whether or not there is a way to enable *partial matches*, I guess it would be *much slower* to also search for partial matches. <span class="fluo_orange_bgnd">**[needs clarification]**</span>

Even if it turned out that there is no way...

<a name="VeryImpressedSearchEngine"><div class="fluo_green_frame">**I'm *very* impressed with the search engine, it's very fast. I've also tested searching through encrypted emails and it works just the same.**

</a>Days later: I'm downloading years of emails from a GMail account, I already have 4.7 GBytes, 7344 emails (and still downloading, they might sum up 12 GBytes), and **I'm getting answers from the search engine in the CLI in 0.002-0.090 sec on a 10+ years old computer, with fully encrypted search index.** About an hour later, I have 5.9 GB, 8886 mails (still downloading) and I'm getting search results in 0.002 1.178 seconds (the 1.178 seconds one was then always repeated in 0.215 seconds, maybe the disk was busy with something else the first time).**
</div>

Don't forget the [**recommendation**](#IfYouEditTagNameThenEditKeywordToo) I've included in a previous section of this document.

<a name="SettingNumOfResultsPerPage"></a>

### Setting the number of results per page

If on the GUI I click the ***Settings and Tools*** gear icon in the upper right corner and then the ***Preferences*** button, I get to the ***Search results per page*** drop-down menu. I can set a value not exceeding what can be displayed on my terminal window. I could also scroll up and down the terminal window, but it might be more confusing than using the commands *Mailpile* offers:

`n` next page  
`p` previous page

Of course I could you both resources, 120 lines per page and I'll scroll through them in the terminal line.

The chosen value will affect both the GUI and the terminal window, I haven't found out if it's possible (without using the python shell) to set two different values. <span class="fluo_orange_bgnd">**[needs clarification]**</span>

<a name="ChangingSortOrderCLI"></a>

### Changing sort order of search results in the CLI

The help text says that I can change sort order with the `o` command, quote:

> o|order&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<how\>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sort by: date, from, subject, random or index

These two give me an "Unknown sort order" error <span class="fluo_orange_bgnd">**[needs clarification]**</span>:  

```
o from
```
```
o subject
```

The other ones seem to work fine and the result of the last search are displayed again in the expected manner.

I haven't seen how to revert the sort order in the CLI. <span class="fluo_orange_bgnd">**[needs clarification]**</span>

(The GUI, from the "hamburger" menu below the **0/1** **ON/OFF** logout icon, allows to choose "Newest First" or "Oldest First".)

<a name="deletingEmails"></a>

## Definitive deletion of emails

(You might want to check out [this recommendation](#nothingElseWhileDeleting).)

<p></p><div class="fluo_green_frame">  
<p>**ATTENTION:** The delete command in *Mailpile*'s Command Line Interface performs **immediate and definitive deletion, with no permanence in the trash, which means:**</p>
<center><span class="fluo_green_bgnd"><big>**NO UNDO**</big></span></center>

<center>However:</center>

<p class="fluo_green_frame">If you are leaving your emails on the remote server, and permanently **delete** some of them **only from the local storage** and not on the remote server, **they will be downloaded again**.</p>

There's a suggestion below [here](#insteadOfImmediateDeletion).
</div>
<p></p>
<div class="fluo_orange_frame">The delete command seems to (correctly) only affect local storage. How I tested:  

- Settings | Privacy | ***Allow deletion of e-mail from servers and mailboxes***: I switched to On (otherwise deletion would appear to be "prohibited")
- Email account settings | Incoming Mail | ***Leave mail on server***  
  I left the checkbox marked (here's again [how to reach the Incoming Mail settings](#IncomingMailSettings))

It has been [suggested on GitHub](#https://github.com/mailpile/Mailpile/issues/945) that there might be two separate settings:

- ***Allow deletion of emails from servers***
- ***Allow deletion of emails from local storage***

I've tested deleting multiple times one message in the Inbox with the delete command, then watching it appear again as *Mailpile* was fetching it again from the remote server.

**DO YOUR OWN TESTS WITH THE *MAILPILE* VERSION YOU'LL BE USING, AND POSSIBLY WAIT A FEW DAYS, BEFORE DEFINITELY ASSUMING THAT THIS IS THE BEHAVIOR.  
Deletion of emails from remote servers as a consequence of immediate deletion from *local* storage with the delete command in the CLI *might* turn out to happen, but after a while. <span class="fluo_orange_bgnd">[needs clarification]</span>**</div>
<p></p>
<div class="lightblue_frame">
<a name="EnablingDeletion"></a>

### In the GUI: enabling deletion of emails

**First of all** in the GUI: ***Settings* | *Privacy* | *Allow deletion of e-mail from servers and mailboxes* => On**  
(Mailpile 1.0.0rc6)

*After* enabling deletion, in the trash I'm seeing a line above all emails saying:  
**"Trash : Messages will be permanently deleted after <span class="fluo_green_bgnd">91 days</span>."**

-----

<a name="SettingDaysInTrash"></a>

### In the GUI: setting the number of days in the trash before automatic definitive deletion of emails

**Here is how to set a <span class="fluo_green_bgnd">lower number of days of permanence in the trash</span> before complete deletion.**</span>

To edit the trash tag settings:

- click the trash icon in the sidebar
- click the "Edit" gear icon above on the left, just below the search engine input field
- click Automation to open that section of the settings
- select a lower number of days after which a messages is untagged and deleted  
  (91 days is the default value and the largest one that can be chosen)

</div>

You can also immediately empty the trash.  

<a name="ImmediatelyEmptyingTrash"></a>

### Immediately emptying the trash (or part of it) using the CLI

Before executing a delete command, you must execute a `search` one (please check out one short thing [above](#unwantedOutputFormatSwitch) if you've jumped here from the paragraph ***Sending emails to the trash***).

<a name="immediatelyEmptyingTheTrash"></a>To immediately empty the trash, I can do:

    search in:trash`  
    delete all

(That's super fast, [unless](#3-4minutesToDelete2500kEmails) you are using *Mailpile* on an old computer, you have 46+k messages, you are deleting 2500+ of them at once and you have set *Mailpile* for full index encryption, in which case you might have to wait for a few minutes, 3-4 minutes here.)

You may want to delete specific emails instead.

    search in:trash

or 

    search your keywords

(the second one searches _out_ of the trash, it won't find emails _in_ the trash)

In case of any matching emails, this gives you a numbered list. You can delete messages with specific numbers or ranges, e.g.

    delete 3,10-15

If you have more emails in the trash or in any tag than the ones you can see at once in the CLI, then after each search:

**Again:**

You can modify ***Settings* | *Preferences* | *Search results per page*** to establish how many lines per page your search operations will give, I've set 40.

`n` next page  
`p` previous page

<p class="fluo_green_frame">**Again:** if you are leaving your emails on the remote server, and permanently **delete** some of them **only from the local storage** and not on the remote server, **they will be downloaded again**.</p>

<a name="TaggingUntaggingUsingTheCLI"></a>

## Tagging and untagging emails using the CLI

<a name="MovingToTheTrashUsingTheCLI"></a>

### Moving emails to the trash using the CLI

<a name="insteadOfImmediateDeletion"></a>If you do not have the time to remove them right away from the remote server first, then instead of deleting them immediately from the CLI, you could move them to the trash (or another tag you create specifically to remind you), which will give you some time to remove them from the remote server first when you are not too busy, and then delete them permanently from local storage. For instance (here I'll use the shorthand `s` for `search`):

    s some words
    tag +trash 1-2,5-13

Suppose that you want to move to the trash all drafts.

    s in:drafts
    tag +trash all

<a name="MovingOutOfTheTrashUsingTheCLI"></a>

### Moving emails out of the trash using the CLI

But then you find out that you are actually going to need a few of those emails as drafts:

    s in:trash
    tag -trash +drafts 97-103

</div>
