Here's my local Inbox.

<a name="MovingEmailsToTheTrash"></a>

## Moving emails to the trash

I have four lines saying **"(Subject not available)"**.  
This is because I don't have the keys with which those messages were sent.[^ChangingMailpileSetup]

[^ChangingMailpileSetup] Actually I *do* have those keys, but not in the *gpg* keyring I'm using at the moment: I sent those emails to myself earlier today with my previous *Mailpile*+*gpg* setup. For this tutorial, I wanted to restart from scratch, so before launching *Mailpile* from the terminal window I did what follows:  
    
    ````
    mv -i ~/.local/share/Mailpile ~/.local/share/Mailpile_renamedToRestartFromScratchForTheTutorial  
    mv -i ~/.gnupg ~/.gnupg_b4_tutorial  
    install -d -m 700 ~/.gnupg  
    gpg -k
    ````
    
    **You don't need to do this now**, I'm just detailing this possibility of easily switching to/from another entire *Mailpile* setup (without having to switch to another user on your computer) because it might be useful to you.
    
    I guess *Windows* users should also be able to rename the corresponding folders.
    
    I'll restore my real *Mailpile*/*GnuPG* setup later.


Let's move those emails to the trash.
