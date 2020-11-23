</div>
<br>
<a name="Disclaimers"></a>

# Disclaimers

<div class="fluo_green_frame">This tutorial comes with no warranties whatsoever, I'm not a *Mailpile* expert nor a certified security expert, I've quoted *Wikipedia* on a few important points and I'm discussing what my own approach is, also mentioning why certain aspects of it actually constitute one of various possible **bets** about possible attacks.

If reading this document you realize that you can't evaluate this information enough to be able to conclude that it promotes awareness of possible security problems, then you should probably do some research on your own and/or find a knowledgeable person that you can trust.

-----

This tutorial isn't in any way proceeding from the team of *Mailpile* developers, it's only my best effort to share hopefully useful information while encouraging more persons to use this powerful email client. All evaluations and opinions expressed here are solely mine.

NOT BEING ONE OF THE DEVELOPERS AND NOT HAVING CONTACT WITH THEM, I MIGHT AS WELL BE IGNORING USEFUL INFORMATION OR EVEN GETTING SOMETHING WRONG.

I can not guarantee that I'll be always in condition to update this tutorial in the future, but you can always fork it and improve it.

-----

In a nonessential [section below](#keysInHardwareDevice), I mention an optional device to hold keys, to hopefully raise the security level against keys theft. I'm not getting *any compensation whatsoever* from the maker. Again: I'm just sharing possibly useful info. That device happens to be the one I *bought*, I can't say anything about any others.

</div>

If you want to jump hands-on on *Mailpile*, at least don't miss:

+ [this picture](#imagWithAddTagTechnicalSettings) which could save you *some* time
+ [this frame](#essentialPoints) with a very few important points

<a name="Introduction"></a>

# Introduction

Why *Mailpile* is so extremely interesting and what should be kept in mind while starting to use it.

<a name="breakthrough"></a>

## Breakthrough

[***Mailpile***](http://www.mailpile.is) is a wonderful email client available for *Linux*, *MacOS* and *Windows*.

I've been using *Thunderbird*+*Enigmail* during years by now, but *Mailpile* has winning features.

**One of its most innovative and important characteristics is that <span class="fluo_green_bgnd">it can very quickly search through encrypted emails</span> without having to decrypt them.** This breakthrough was implemented by mean of a search index.[^searchIndex]

[^searchIndex] The<a name="warningSlow"></a> search index itself can optionally be totally encrypted as well.
  <p class="fluo_green_frame">**The *Security and Privacy Settings* page [warns with the word "slow"](#stronglyEncryptIndex_slow) about this choice, and actually the default would be *partial* encryption of the index.**</p>  
  I've chosen to cope with the additional time. Here's the lower right portion of the GUI with my second "real" *Mailpile* setup, which includes two *GMail* accounts with many years of emails (and spam, which I'm going to be able to move to the trash, or directly permanently delete, much faster in *Mailpile* than via webmail, while I've used webmail to delete all emails from *GMail* servers):
    
    <a name="astonishingSearchEngine"></a>*image 60b*  
    ![img 60b](pictures/mailpile__img_60b.jpg)
    
    **Searches can actually take much less time than that**, and a repeated search even goes down to 0.001 seconds.  
    <div class="fluo_green_frame">**So, what might become slower with full search index encryption?**  
    (As far as I can speculate at the moment, of course. <span class="fluo_orange_bgnd">**[needs clarification]**</span>)  
    
    I'm **not sure** that what follows is actually related with the full encryption of the search index, **but I suspect so** because I don't see anything else slow.
      
    + <span class="fluo_green_bgnd">**The first login**</span> after starting up *Mailpile*, with over 46k messages, **now takes over 45 secs on this old computer** (it would take considerably more on a *Raspberry* PI4).  
      It takes 2-3 seconds in my other non-*GMail* setup, which has less than 300 messages because the previous ones are all in *Thunderbird*.  
      You can not use *Mailpile* from the CLI or the GUI before having made at least one login after startup, which can be done in the GUI or in the CLI with the command: `login`\<enter\>
        - If you log in via the GUI, you'll also be able to use the CLI.
        - If you log in via the CLI you'll have to type your passphrase again in the GUI in order to be able to use it, hence you may want to login directly in the GUI (unless you are staying with the console alone).
      
    + After logging out from the GUI without shutting down *Mailpile*, logging back in is "instantaneous" after typing your passphrase, as is logout.  
      <span class="fluo_green_bgnd">**Shutdown**,</span> on the other hand, occasionally took up to 2-3 minutes on this old computer, even on my non-*Gmail* setup with less than 300 emails, so don't plan on shutting down and leave home in a hurry, do it with some anticipation.
        
        In the CLI, part of the answer to the `help` command is:
        
            cleanup                       Perform cleanup actions (runs before shutdown)
        
        I guess that's the reason why shutdown can take some time (possibly a bit more because I've opted for a strong encryption of the search index).
      
    + <a name="3-4minutesToDelete2500kEmails"></a>It took 3-4 minutes on this old computer to <span class="fluo_green_bgnd">**permanently delete at once many** (2500+) **conversations from the Trash**</span>, in my *Gmail* setup which had more than 46k emails (done [with the CLI](#immediatelyEmptyingTheTrash) of course).
      
    + A "timeout" problem, with a 25.9 MB email containing various pictures, _might_ have been related with the choice of full-encryption for the search index.</div>


*Mailpile* enables you to ***easily*** send and receive encrypted emails (believe it or not, despite all the info and caveats reported here LOL).

**It keeps your settings and email messages encrypted in your local storage**, optionally also the messages you received unencrypted. You don't need to keep your signatures in separate unencrypted files, easy to read for any intruder.[^signatures]

[^signatures] "Signatures" is the common denomination for a few lines of text that you might want to automatically be added at the bottom of your emails (of course it's not about digitally signing emails).

*Mailpile* interacts with the servers of your email service providers, copying emails and folders to your local storage.

Optionally, *Mailpile* removes your emails from the remote servers, *not* by default (although that would be the philosophy that the project leader recommends to embrace, keep your emails on your computer[^Video2013]).

[^Video2013] <a name="Video2013"></a>Video: [**Bjarni Einarsson: Mailpile**](https://www.youtube.com/watch?v=v_hCmxTH9ag)  
  From this video, I'd also say that the design philosophy was not that of a "touch and go" e-mail client, but more a process running all day long, keeping things synced, while the user would login in the GUI once in a while. I'm rather using it "touch and go", taking into account that startup and shutdown can take a few seconds to a few minutes.

<span class="fluo_orange_bgnd">I still need to find clarifications on a few things, I'll mark them with this color and add "**[needs clarification]**".</span>

<div class="fluo_orange_frame">Disabling "Leave mail on server" in the email accounts settings[^IncomingMailSettings], my emails are actually disappearing from the remote Inbox folders, although not always at once. I'll see if I can find a way through the GUI or the CLI to:

- immediately delete emails on remote servers and compact remote folders
- check what's the actual situation in remote folders.

I can do both things connecting in webmail with a browser (I use *Firefox* and *Vivaldi*) or with *Thunderbird*. <span class="fluo_orange_bgnd">**[needs clarification]**</span>

I understand that the developers had to respect priorities during this certainly *huge* amount of work, and that not all functionalities are already accessible through the Graphical User Interface (or GUI), nor a full documentation is available. **But it's evident that the development has been done with high quality in mind. Just to mention one point: the search engine performance is [astonishing](#astonishingSearchEngine).**</div>

[^IncomingMailSettings] How<a name="IncomingMailSettings"></a> to reach the "Incoming Mail" settings:  
    - click on the Inbox tag in the sidebar
    - in the upper left corner of the GUI click the envelopes icon
    - specifically for the Incoming Mail settings, click the "ethernet + arrow down" icon[^EthernetArrowdownIconColorChanges] for the account which "Incoming Mail" settings you want to modify (right below the small gear icon labeled ***Settings***).
    
    Some of the settings in this section are:
    - ***Forget password***
    - ***Leave mail on server***
    - ***Copy all mail and add to search engine***  
      <span class="fluo_orange_bgnd">I haven't tested what happens disabling this one when creating the account, possibly new incoming mails are fetched and not pre-existent ones, but I'm just wondering, I'll have to try **[needs clarification]**</span>
    - ***Enable this mail source***

[^EthernetArrowdownIconColorChanges] **The color of the "ethernet + arrow down" icon changes**, green if the last connection to the incoming mail server succeeded, red if not, and <span class="fluo_orange_bgnd">possibly gray – apparently not always – if *Mailpile* has been offline during *some* time and is now simply trying to connect to the incoming mail server each *n* seconds (300 seconds the default interval). **[needs clarification]**</span>  
  By **hovering** the mouse cursor on the icon, a hint-formatted message appears telling what the **situation** is.


<a name="OpenIssues"></a>

## Open issues

<div class="fluo_green_frame">Here's the <a name="GitHubMailpileIssues"></a>[GitHub page for *Mailpile* issues](https://github.com/mailpile/Mailpile/issues). I've read a bunch of them, I think that it is possible that some of the issues which appear to be still open have been resolved through other fixes by now. The current development status looks better *hands on* than on that page.

Again, I'm using version 1.0.0rc6, which means the 6<sup>th</sup> candidate to become release 1.0.0.

- If you get a "Template Not Found" text (I got it twice in over one month now), try reloading [http://localhost:33411](http://localhost:33411), and if that doesn't work, logout from the GUI and login again and you should be fine.
- Emails sent with *Mailpile* with digital signature but not encrypted, received in *Thunderbird* ver. 68.10.0 + *Enigmail* ver. 2.1.6, might result in a message "Unverified signature". **Signed <u>*and encrypted*</u> emails do not present this problem.** It might be more likely to happen when *forwarding* emails with attachments. Reported [here on *GitHub*](https://github.com/mailpile/Mailpile/issues/2274). I'd normally *also encrypt* when sending to anybody who is in condition to check signatures (but sometimes you do not know).
- There is a sporadic issue with the `search` command in the CLI, [see below](#searchSideEffect).
- Another issue to take into account: compatibility with python 3 not achieved yet, it has been [mentioned on *GitHub*](https://github.com/mailpile/Mailpile/issues/2263).
- <a name="newEmailNotAppearing"></a>Reported [here on GitHub](https://github.com/mailpile/Mailpile/issues/2272): occasionally *Mailpile* was not showing a new incoming email which presence on remote servers *Thunderbird* wasn't failing to reveal. It was happening occasionally with only one of various accounts. A new email arriving into that account (even if sent from the same account, with *Mailpile* itself or another client) caused *Mailpile* to immediately correctly show all emails arrived into that account.  
  As the report says, there's **possibly a workaround:** add a second source disabling the first one, easily done in the GUI.[^adding2ndSource] Then, in case no new emails are appearing in that account, disable the currently active source and enable the other one, and of course let *Mailpile* connect to the server again.  
  **Although nobody else has reported that issue, which is happening with vivaldi.net, this is definitely *the* only real single important issue in my opinion at the moment, I hope it will be looked into soon, I would be able to recommend *Mailpile* more effectively.**[^stormyWeather]
- Icons <a name="toolbarIconsBadlyPositioned"></a>in the toolbar can be badly positioned if the toolbar isn't long enough. **Enlarging the GUI window horizontally** helps, if possible ([below](#mouseHoverHintsInTheWay) there is mention of another reason for it).

</div>

[^stormyWeather] I'd look into it (I did *very* little coding in python in the past but it doesn't seem more difficult than other languages I've worked with... *Mailpile*, though, is probably a rather complex project requiring some time to dig into it). But I have stormy weather incoming, meaning that I must relocate and outgoing money is going to be multipled by *n*, which means I'll have less time to work for free. Before, I hope to be able to finish prioritaire *ad honorem* ongoing works (actually, I've given priority to this tutorial despite a friend's recommendations).

[^adding2ndSource] Open the [Incoming Mail settings](#IncomingMailSettings) and mark the checkbox labeled ***Add New***, a new section will appear immediately, start by the dropdown menu where you initially read "None", there you choose the connection protocol and immediately more input fields will appear. You can copy the same settings as the first source if the symptoms where simply anomalous, or you can type in alternative settings if you got them from the account provider or the related support forum. Before saving, remember to _disable_ the previous source by "unmarking" the ***Enable this mail source*** checkbox

<a name="notIssuesToBeAwareOf"></a>

## Non-issues to be aware of

- <span class="fluo_green_bgnd">**NOTICE:** if you send an email <u>*to yourself*</u> from *Mailpile* itself, *Mailpile* won't show it in the *Inbox*, you'll only see it among *Sent* emails, despite the fact that by default *Mailpile* sends a copy to your account.</span>  
    
    (<u>*To yourself*</u> meaning: <u>using *Mailpile* to send</u> from one to another of the email accounts you have configured in *Mailpile*, or to the same one from which you are sending.  
    You *will* see that email in *Mailpile*'s Inbox if you have sent it from another client, e.g. *Thunderbird*, even if sent from one of the email addresses that you have also configured in *Mailpile*.)  
    
    **This can be confusing *at first*, but it's actually a smart way to allow you to handle your emails both in webmail *and* with *Mailpile*, while avoiding to see duplicates of all emails you send, despite having a copy on remote servers.**  
    (You can choose at any moment *not* to send a copy to yourself, and *not* to leave emails on remote servers.)  
    &nbsp;
- When you add an email account and connect to its server, *Mailpile* by default starts downloading *all* emails in it, starting with the most recent ones, it doesn't at the moment offer an option to limit the synchronization to the last *n* days.  
  It has been [suggested on *GitHub*](https://github.com/mailpile/Mailpile/issues/1098) to implement the option to limit download to the last *n* days. The project leader answered explaining that it isn't straightforward to implement that feature without having to parse all emails, considering that certain servers do not maintain an index on date-time.  
  &nbsp;
- I can't see pictures linked to remote storage embedded in emails, despite explicitly asking *Mailpile* to let me view those pictures.[^optionToSeeLinkedImages]  
  **I think it isn't an issue but a render feature not yet implemented.**  
  There's an easy **workaround:  [save the email](#saveMessageBody) and open it in your browser**.  
  It is actually the best thing to do, call it good practice.
  *Your browser* is what you use to surf the web with some protection against malign code, with your preferite plugins, and you might launch a [**completely separate session**](#separateFirefoxInstance) so an attack wouldn't directly arrive into your email client.  
  &nbsp;
- <span class="fluo_orange_bgnd">I'll see if I can find a way</span> to tell *Mailpile* "please **do check right now if there are any new incoming emails"**.[^noShorterInterval] Often, when going online after some time offline, *Mailpile* with default source settings checks right away if there are incoming emails, but sometimes it doesn't. At worst, apparently, it's a matter of 5 minutes.[^keepalive_interval]  
  &nbsp;
- <span class="fluo_orange_bgnd">I'll see if I can find a way</span> to **modify the format of a previously typed in e-mail address**. For instance: I'm sending an e-mail, I type in the recipient's address, let's say info@somegroup.org and, after realizing that only "info" shows up (unless hovering the mouse cursor), I decide to type in a differently formatted address, for instance:
    - Some Group <info@somegroup.org>
    - "Some Group" <info@somegroup.org>
  
    but *Mailpile* will always reduce it to what I had typed before, showing just "info". <span class="fluo_orange_bgnd">**[needs clarification]**</span>  
  &nbsp;
- <span class="fluo_orange_bgnd">I'll see if I can find a way</span> to **change word wrap settings**.
    - I don't always like the outcome of word wrapping (checking how my emails sent with *Mailpile* look in Thunderbird).
    - Saving a draft email implies wrapping. Retaking it, adding some text and sending can let the previous parts wrapped and the new one not wrapped.
  
    I'd like to be able to just switch it off. <span class="fluo_orange_bgnd">**[needs clarification]**</span>  
    &nbsp;
- Mouse <a name="mouseHoverHintsInTheWay"></a>hover **hints** in the GUI sometimes get **in the way** of mouse operations, e.g. when deactivating digitally signing one mail. Simply **enlarging horizontally** my browser window solves it ([above](#toolbarIconsBadlyPositioned) there is mention of another reason for it).
  &nbsp;
- I can't edit the text signature at the bottom from inside a new email (something *Thunderbird* allows).  
  For specific recipients, I might want to modify my signature at the bottom, e.g. omit my cell phone number or PGP related lines.  
  Apparently *Mailpile* obliges me to change the signature in the profile. <span class="fluo_orange_bgnd">**[needs clarification]**</span>
- **It's <a name="nothingElseWhileDeleting"></a>possibly good practice not to do anything else while *Mailpile* is permanently deleting emails**. (Today I launched the delete command in the CLIto immediately delete various emails from my huge *GMail* setup, which was probably going to take a few seconds on this old computer, with fully encrypted index. So, after launching the delete command, I immediately started doing something else via *Mailpile*'s the GUI. The GUI worked fine but I got a message in the CLI that the delete operation had failed. I launched it again without doing anything else and it went through just fine.)

[^noShorterInterval] Without having to configure a smaller value for the "interval" setting.

[^optionToSeeLinkedImages] These options appear in a small frame with an eye icon, on the left in the message body area. You can see that frame in the lower left fourth of [this image](#imageWithEyeIconFrame_A) and [the one which follows it](#imageWithEyeIconFrame_B):
    
    > This message references images or other content from the web. Downloading and displaying these images may notify the sender that you have read the mail.  
    >
    > Okay, display the images  
    > Always display images from this sender  
    > No, thanks!

[^keepalive_interval] The default setting is keepalive activated. Apparently, after a certain amount of time offline, *Mailpile* switches to another mode, just trying once each *n* seconds, being 300 apparently that value.  
  Disabling keepalive and setting an interval of 300 seconds between connections is mentioned in an [issue](https://github.com/mailpile/Mailpile/issues/2272) report [mentioned above](#newEmailNotAppearing), which links [**this page**](https://community.mailpile.is/t/hints-for-developers/562) explaining **how to see all settings and how to modify those settings via the <span class="fluo_green_bgnd"><fixed>set</fixed></span> command**.  
  **You can use the <span class="fluo_green_bgnd"><fixed>unset</fixed></span> command, identifying settings the same way, to restore default values.**  
  By default, interval = 300 appears to be commented out. I guess it's still a default behavior in case keepalive has not been possible for a while. **After having been offline for hours, I'd expect the 300 seconds to have elapsed.** Maybe what's not easily detectable in a way that would be portable to different platforms is that the computer is back online without actually trying to connect, in lack of which possibility the philosophy might have been to stop trying on and on. <span class="fluo_orange_bgnd">**[needs clarification]**</span>

<a name="EncryptionMadeEasy"></a>

## Encryption made easy for non-tech savvies

***Mailpile* can create and manage encryption keys for you, if you prefer, or it can use your own pre-existent keys.**

<div class="fluo_green_frame">You can choose whether or not to let *Mailpile* memorize your keys passphrase, both for keys created by *Mailpile* and pre-existent keys.

Would it be more secure to type in the keys passphrase when *Mailpile* requires it once in a while?

That's **quite a bet**, I don't know if there are more chances that my keystrokes can be recorded at some point or that the encryption with which *Mailpile* saves my settings gets compromised (or even that a [side channel attack](https://en.wikipedia.org/wiki/Side-channel_attack) grabs my secret keys *anyway*).[^trickAboutKeystrokes_strongLoginPassphrase]

The possibility to use **a hardware device to hold your secret keys** is [mentioned below](#keysInHardwareDevice) in this document.

</div>

[^trickAboutKeystrokes_strongLoginPassphrase] You'll think "if your keystrokes are being recorded, your *Mailpile* passphrase is compromised as well". Well, I've come up with a method to raise the bar just a bit, but *publishing* the trick wouldn't be the best security policy. Not knowing if my keystrokes had been watched before I came up with it, I've changed the *Mailpile* password afterwards.  
  Absolutely secure now? Of course not, I'm simply progressively learning good practices to *raise the sophistication level* that an attacker should have to succeed.

<a name="Tags"></a>

## Tags

*Mailpile*'s GUI enables you to [classify selected messages](#UsingTags) by a simple mouse-button click. **Tags** can work in two ways:

- **categories** (like folders)
- **attributes** (cross-folders groups)

Tags can also be **nested** one inside another. It is an extremely flexible tool to keep your messages organized.

[From the CLI](#Mailpile_CLI), it is also possible to [tag and untag emails](#TaggingUntaggingUsingTheCLI).  
CLI + tags = a *powerful* mean to classify or trash or immediately delete huge amounts of emails.

<a name="Design"></a>

## Design

The GUI is *beautifully* designed, keeping functionality in mind. One of *Mailpile* creators is a real designer.[^again2013video]

[^again2013video] As you can see in the [already mentioned](#Video2013) 2013 Video [**Bjarni Einarsson: Mailpile**](https://www.youtube.com/watch?v=v_hCmxTH9ag).

<a name="EasySetup"></a>

## Easy installation and setup

The installation procedure was very quick and easy on *Ubuntu Linux* 18.04[^UbuntuKernel], following the instructions on their [website](http://www.mailpile.is) to add their repository.[^onlyFirstPackage]

[^onlyFirstPackage] There is a second package, to have *Mailpile* act as a server for connections from other machines. I've only installed the first package for now. If you want to also test the second one, be sure to read the developers' warnings about security still needing to be checked out and possibly improved. (If you don't need a "real" Apache style server, I think there shouldn't be any problems setting an SSH tunnel from another machine and running the web browser on it, not even X forwarding should be necessary, and on the other machine the port number might be a different one.) 

[^UbuntuKernel] Yes, I've read rumors about Debian (hence derivatives like *Ubuntu*) having been infiltrated by the NSA. I've been considering moving to another distro with no specially made kernels (and no plans about making auto-update, <i>update-at-any-moment-without-asking</i>, a characteristic of the next major release, although I admit that I haven't been following the matter since reading a [very long *Reddit* thread](https://www.reddit.com/r/linux/comments/gc7p1t/ubuntu_2004_lts_snap_obsession_has_snapped_me_off/?sort=new) with plenty of users preliminarily complaining about that), they might have decided to add an auto-update ON/OFF switch.  
  **Which *Linux* distributions would be more secure and still allow to easily run plenty of software available over the Internet?**

<a name="MultipleAccounts"></a>

## Multiple email accounts

*Mailpile* can handle multiple email accounts, I'm not losing this important feature switching from *Thunderbird*.

<div class="fluo_green_frame">If you are not already used to having multiple email accounts in the same client at once, you might end up answering from one account an email you had received into another account.

- If you are using different accounts to simply keep things tidy and clearer for you, that's not a big deal.
- If it's a matter of life and death, a mistake might put you in **DANGER**.  
  In general, consider triple checking from which account you are sending an email, or consider handling one account at a time.[^RenameMailpileFolder]</div>

[^RenameMailpileFolder] <a name="MailpileFolderDefaultLocation"></a>You can simply keep different *Mailpile* folders to have various completely separate setups that you will use one at a time. In *Linux* you don't even have to rename or move the folders, which could become confusing. You can create a symbolic link to the folder you want to use, making it accessible as `~/.local/share/Mailpile/`  
  You can put the commands to switch among your setups in one or more bash scripts, which would preventively test `pgrep mailpile` and exit with an error message if you are trying to switch while *Mailpile* is running. For instance:
  
        procName=mailpile
        
        procID=`pgrep -x "$procName"
        if [ "$procID" != "" ]
        then
            echo ""
	        1>&2 echo "***** $procName process running (PID $procID) - NOT switching *****"
        else
            ...
  and it deletes your symbolic link and creates another. My own script also checks what the situation is, folders and link found or not found, before doing anything, just in case there were any unexpected problems left previously.  

<a name="HandsOn"></a>

# Hands-on session

Again: I am using *Mailpile* 1.0.0rc6, which means the 6<sup>th</sup> candidate to become release 1.0.0.

**Here is a basic post installation startup tutorial.**

When I started this tutorial, I would have liked to have more emails to test on already, but with *Thunderbird* I used to *remove* emails from remote servers. I *enthusiastically* wanted to make this tutorial anyway, because I know quite a few different groups of persons who would be glad to use *Mailpile*, for instance a few journalists, and a friend in a humanitarian non-profit organization that was needing something exactly like *Mailpile*, to make a transition towards better protection of their supporters' privacy and financial data, while staying compatible with their pre-existent email services *and* being able to search through encrypted emails.

<a name="StartingMailpile"></a>

## Starting *Mailpile*

On Linux, I start *Mailpile* from the terminal window:
