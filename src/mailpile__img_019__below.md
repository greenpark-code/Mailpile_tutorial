<div class="fluo_orange_frame">
 <span class="fluo_orange_bgnd">**[needs clarification]**</span>

- **In *Thunderbird***, when clicking the **Inbox** of an account (on the upper-left part of the GUI), I see the actual content of that remote Inbox at the moment of the last connection.
- <span class="fluo_orange_bgnd">**In *Mailpile***, by what I see when clicking one of those **INBOX** subfolders in the sidebar, I'd say that they are a mean to see ***all* emails** arrived **into *that* account**, **including the ones we have already moved to tags-categories** (we'll see later), while the **Inbox** link **in the upper part of the sidebar** shows emails arrived into **all** of the configured **accounts** and **not yet moved to any tag-category**.</span>
  
It's <span class="fluo_orange_bgnd">unclear</span> to me at the moment if there is already a way through *Mailpile*'s GUI to do the following operations, which are intuitive in *Thunderbird*:

<table>
<tr><td>**desired action**</td><td>**how-to in *Thunderbird*** (being online)</td></tr>
<tr><td>check what's actually in the remote folders at the moment</td><td>left-button click the remote folder</td></tr>
<tr><td>immediately remove emails from remote folders</td><td>drag emails from remote to local folders, or select emails then shift-del</td></tr>
<tr><td>"compact" remote folders</td><td>right-button click and choose "Compact" from the contextual menu (same as for local folders)</td></tr>
</table>

I can do those things connecting to the account with my web browser in webmail, or with *Thunderbird*. Actually, I'm doing that progressively less frequently, because I'm seeing that *Mailpile* is also working fine when configured not to leave emails on servers.

</div>
<br>
I'm going to click the ***Inbox*** link in the upper part of the sidebar, just below ***Drafts***.

<br><a name="MailpileWithGMail"></a>

<div class="lightblue_frame">
### Configuring *Google Mail* accounts in *Mailpile*

(I'm adding this section days later.)

At first, I let *Mailpile* detect all settings, and I was required to authenticate in a pop-up window, but after doing so I got a window from Google saying that I couldn't sign in with this app.

The solution is to generate an "App password".

- **In *GMail***, after logging in with my web browser in webmail:
    - I clicked my profile icon in the upper right corner
    - I clicked ***Manage your Google Account***
    - On the left I clicked ***Security***, aside the lock icon
    - In the "Signing in to Google" section, I clicked ***App passwords***, the rest is guided:
        - I typed in a name to remember what that password is about, it can be "Mailpile" or anything else you want
        - I was asked to confirm the one among various numbers which was appearing on both screens, phone and web browser on PC
    
    **That's all, a password was then visualized ready for me to type or copy and paste in *Mailpile*.**
    
- **In *Mailpile***, after letting it automatically fill-in the Incoming and Outgoing Mail settings:
    - I changed the type of authentication from OAuth2 to password, ***both* for Incoming and Outgoing mail**
    - as the password, I copied&pasted the app password I had on screen from *GMail*

At once, the structure of my remote folders in that account appeared and *Mailpile* was fetching my emails.

<a name="FastDespiteManyEmails"></a>**Despite having now downloaded [almost 17 years of emails (over 46k emails exceeding 14GB)](#VeryImpressedSearchEngine) and despite having [chosen full index encryption](#SecurityAndPrivacySettingsModifiedFromDefaults), *Mailpile* is still very fast searching, <u>a *wonderful* client undoubtedly</u>.**[^TestedDisablingCopyAllMail]

**However**, [this note](#warningSlow) mentions what is possibly slower because of having opted for full search index encryption.

</div>

[^TestedDisablingCopyAllMail] Actually, when first adding the *GMail* account into *Mailpile*, I also wanted to test disabling since the beginning **"Copy all mail and add to search engine"** in the [Incoming Mail settings](#IncomingMailSettings).  
  
    What happened? I could send emails through *GMail* SMTP server, but *Mailpile* wasn't fetching any, not even if I sent new emails to that account.  
  
    Immediately after enabling **"Copy all mail and add to search engine"**, the (large) structure of my remote folders in that account appeared and *Mailpile* was fetching emails.

Now, back to my *Mailpile* setup for this tutorial.
