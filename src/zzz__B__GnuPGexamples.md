<a name="gpgExamples"></a>
<big><span class="notEssent_gpg_bgnd_fg">This is not essential to use *Mailpile*</span></big>
<div class="notEssent_gpg_frame">

# Appendix: a few examples with *GnuPG* on the command line – not essential to use *Mailpile*

<div class="fluo_green_frame">This appendix only contains a few examples, related to this document, of *GnuPG* usage on the command line **in a *Linux* terminal window** (I haven't seriously tested interacting with *gpg* from *Mailpile*'s CLI).  
**This is not exhaustive information on *GnuPG* usage. There are many good tutorials on the web, some of which specific on one aspect.**

</div>

<a name="perfectKeypair"></a>Here's a nice tutorial about **creating *GnuPG* keys**, the one I follow more or less to create my own keys (air-gapped, with no picture and with a few other differences):  
[**Creating the perfect GPG keypair – Alex Cabal**](https://alexcabal.com/creating-the-perfect-gpg-keypair)[^againPerplexities]  

[^againPerplexities]Yes *do* I realize that the familiy name of the author is not the most reassuring part of the tutorial LOL, in this context it looks like a nickname of somebody playing mind games with his readers.  
  And you have probably already read about certain perplexities, [here](#ImayChoseRSA4096despite) and [here](#Kleptography_NSA), which for now I've chosen to resolve opting for RSA4096 while awaiting for practical applications of upcoming results of research on post-quantum cryptography.

As the tutorial recommends, **I keep the whole result with the primary key stored apart and actually export and use *the subkeys***.

Let's see examples related with other aspects.  

<p class="fluo_green_frame">EACH ONE OF THE FOLLOWING COMMAND LINES HAS TO BE TERMINATED WITH THE \<ENTER\> KEY.</p>

<a name="ListingPubKeys"></a>

## Listing the public keys in the keyring

    gpg -k

(lowercase k)

<a name="ListingSecretKeys"></a>

## Listing the secret keys in the keyring

    gpg -K

(uppercase K)

<a name="ExportingPubKey"></a>

## Exporting a public key from the keyring

    gpg -a -o pubkey.asc --export myemail@addr.ess

<a name="ExportingSecretsFromKeyring"></a>

## Exporting secret keys or subkeys from the keyring (not if held in a hardware device)

**Evaluate _where_ you are saving this file and consider [securely removing](#handlingSensitiveFiles) it afterwards.**

    gpg -a -o secretkeys.asc --export-secret-keys myemail@addr.ess<enter>

To only export secret sub keys without the primary key:

    gpg -a -o secretsubkeys.asc --export-secret-subkeys myemail@addr.ess<enter>

<a name="Importing"></a>

## Importing public or secret keys or subkeys or a revocation certificate

    gpg --import filename

<a name="EncryptingSigning"></a>

## Encrypting, signing

You might do something like this, possibly in an [air-gapped](#airGapped) machine (I switch to another e-mail address only to "simulate" the air-gapped scenario, that is to remind that I might be using another key with an invented e-mail address associated to it only to be able to easily select the key while using it):

    gpg -o toX.tar.gpg -u me@airg.xxx -r x@airg.xxx -s -e toX.tar

me@airg.xxx would be an invented user id associated to this key you have created not to actually directly use with email, probably specifically for air-gapped use with X, and x@airg.xxx the user id for X's key, *GnuPG* won't bother because those email addresses do not exist, it's just keys IDs so we don't have to use hexadecimal ones. Actually the user ID also identifies all related subkeys, one subkey will be specifically used to sign, another one to encrypt (and optionally you can add a subkey to authenticate which can be used with SSH connections). See above the link to Alex Cabal's tutorial about keys creation.

Instead of .tar it could be .zip or .txt or .rtf or whatever other extension, actually **the name and extension of the input and output files are not relevant to *GnuPG*.**  
You can attach the resulting binary file toX.tar.gpg to a *Mailpile* email which is going to be encrypted with yet another key.  

Or if you have a short message or any small file which you want to encrypt and copy&paste into the email body (again, instead of .txt it could be .rtf or whatever):  
    gpg -a -o toX.txt.asc -u me@airg.xxx -r x@airg.xxx -s -e toX.txt

You can still *attach* an ASCII file of course, but to that goal I'd go binary.  

The following four lines are not commands, they mention options.


| short option | long equivalent |
| :----------: | :-------------- |
| `-a`         | `--armor`       |
| `-o`         | `--output`      |
| `-s`         | `--sign`        |
| `-u`         | `--local-user`  |

<span class="fluo_green_bgnd">Specifying a local user is only necessary if you have more than one secret key in the keyring and the one you want to use is not the default one</span> (which would normally be the first one you get with `gpg -K`).

If you and your correspondent haven't yet exchanged a public key for air-gapped use, you might use **symmetric encryption**, the result will possibly be a smaller file, especially evident if you are encrypting a small file, but **it won't be as strong as asymmetric encryption with a proper key**.

    gpg -a -o toX.txt.asc -c toX.txt

If at least *you* have previously passed to your correspondent your public key, you can sign (-s) even if you are using symmetric encryption:

    gpg -a -o toX.txt.asc -u me@airg.xxx -s -c toX.txt

<a name="Decrypting"></a>

## Decrypting

    gpg -o toX.txt -d toX.txt.asc

If your correspondent has already imported your public key and you encrypted with the -s option to include your signature, *GnuPG* will tell your correspondent that there is a good signature from you.

<a name="DetachSig"></a>

## Creating a detached signature and verifying one

If you want to add a separate signature of a file:  
    gpg -u me@airg.xxx --detach-sig myFile.abc

The result will be a detached signature file named myFile.abc.sig

Anybody having imported your public key and receiving that file will be able to verify your detached signature of that file, which certifies that the file hasn't been altered since you signed it:  
    gpg --verify myFile.abc.sig

or:  
    gpg --verify myFile.abc.sig myFile.abc

<a name="TextSignatureAtTheBottom"></a>

## The term "signature" is possibly confusing

The few lines of text that I want my email client to automatically put at the bottom of my emails are also called "signature".  
They have *nothing to do* with the actual digital signature of my email message, which proves:

- that I wrote the message
- that it hasn't been altered

*But* they might be used to also carry information about my PGP key for that account:

1. the primary key hexadecimal ID
2. the fingerprint

To obtain the fingerprint:

    gpg -o myFingerprint.txt --fingerprint my.email@addr.ess

and you only use the line containing "Key fingerprint = ..." because that is what can and should be obtained by anybody only having imported your public key, after importing it, with the same `gpg --fingerprint my.email@addr.ess` command, *provided* that the key they have imported has not been altered.

**If the fingerprint doesn't match, then the public key they have imported is not your uncorrupted/unaltered public key.**

<a name="TemporarilyAnotherKeyring"></a>

## Temporarily using another keyring

    gpg --homedir relativePathToReplacementGnupgFolder --whatever-options-and-command

E.g.:

    gpg --homedir /media/myuser/ENCR_FLASH/somepath/.gnupg_withMoreSecretKeys -K

<a name="BeforeSigningKeys"></a>

## Before signing somebody else's keys...

<span class="fluo_green_bgnd">Finally: many tutorials out there explain the meaning and the how-to of **signing the keys of other persons**.  
Just remember to do so ***after* setting your trust level** for those keys.</span>
</div>
