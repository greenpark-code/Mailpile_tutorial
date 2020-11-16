The four icons below the small gear labeled ***Settings*** allow me to access the account settings.

- **Incoming Mail** settings (can also add/disable/enable email sources for the specific account, [here](#IncomingMailSettings) is how to come back to these settings at any moment, hence to the following ones too)
- **Outgoing Mail** settings
- **Security** settings, <a name="reassigningKeys"></a>including <span class="fluo_green_bgnd">keys</span>
- **Profile**, including <span class="fluo_green_bgnd">a short text usually called "signature" which I might want at the bottom of my emails</span> (not to be confused with the actual digital signature which guarantees that I'm the author of the message and that the message itself hasn't been altered)

**I don't need to modify anything now, as the default settings and the ones guessed by *Mailpile* are just fine for me**. I can omit pictures, so this tutorial won't appear unnecessarily (even more) long and scary.

<div class="fluo_green_frame">**IMPORTANT NOTICE:** these are actually **sections of the same "dialogue"**.

**When you press the *Save* button, you are saving the settings in *all* sections.**

If you are modifying the servers settings but *Mailpile* doesn't find your secret keys (e.g. because you activated another .gnupg folder and forgot to restore the previous one), then you will also be confirming what's in the other sections of the dialogue, and for "Security and Privacy" you'll be choosing the default behavior in absence of keys, which is, at present, the **creation of new EdDSA keys for the account**.

**Beware that afterwards you might be sending e-mails signed with this new secret key and you might be attaching a new public key, instead of using the pair you had previously associated with this account.**

When you need to leave "dialogue" windows of this kind without modifying anything, you can click the **x** in the upper right corner (you have already seen the "Create a new Account" and "Password Required" dialogues).
</div>

<a name="CopyOfTheRemoteFoldersStructureInSidebar"></a>

### Copy of the remote folders structure and content is accessible in the sidebar

Notice, in the lower right corner of the above picture, that I mistyped the password of one of the two email accounts I've added.  
In fact, in the **sidebar** on the left I have the **copy of the remote folders structure** of one account only.  
No problem, by clicking the ***please login*** link under the notification I will be able to type the password again.

We'll see [below](#OrganizingSidebar) how to **change the order** of the elements appearing in the **sidebar**.
