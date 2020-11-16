<br>
<a name="essentialPoints"></a>If you **lack** the **time or will** to read the following "not essential" section, then read this frame content (but I'd recommend that someday you read the part you are skipping now):  
<div class="fluo_green_frame">

If anything more complicated than "normal"[^normalEmailsShouldBeEncrypted] unencrypted emails means no encryption at all for you, then let's choose the easiest way for now, *any* level of security on your emails is better than none.

1. Check out [this recommendation](#separateFirefoxInstance).
2. **Remember <a name="forwardSecrecy"></a>that encrypting doesn't mean that you can be absolutely sure that your messages are and will always be secure**.  
*GnuPG* doesn't support **"forward secrecy"**: <span class="fluo_green_bgnd">if a key is compromised then the secrecy of all past messages encrypted with it is compromised.</span>  
**You can periodically revoke secret subkeys (or even preliminary set an expiration date on them)** and create new ones, but it's not the same as having different keys for each communication session.
3. Flip a coin to choose your key type. [I may still choose RSA4096 for now](#ImayChoseRSA4096despite), despite [**RSA Security having been the target of strong accusations of adding backdoors**](#Kleptography_NSA). I may [add further encryption levels](#HigherSecurity) with other encryption types for important messages.
4. Let *Mailpile* create and manage your keys for now.
5. Click the button and move on to the [next step](#accessingEmailAccount).

</div>

[^normalEmailsShouldBeEncrypted] Our "normal" everyday emails should all be encrypted. For years, I've been seeing blogs on the web recommending to encrypt every email, even "let's go for a picnic". It took me *some* time to understand *why*, being "I've nothing to hide" the first thought we all have. One of various good reasons is to help journalists who *need* to protect their sources. Epistolary secrecy, right to privacy, is a fundamental ingredient of any democracy.  
  ***Aleksandr Solzhenitsyn***, despite being a brave officer, went through various years in a *gulag* because he *privately* wrote to a friend criticizing how Stalin was leading war.  
  Today, NWO-controlled governments are apparently trying to push in the same direction, as per Trilateral Commission statements about correcting an "excess of democracy"...


<br>

<big><span class="notEssent_security_bgnd_fg">This is not essential to use *Mailpile*</span></big>
<a name="AboutKeysAndSecurity"></a><div class="notEssent_security_frame">

# About keys and security – not essential to use *Mailpile*

***Mailpile***, just as *Thunderbird*+*Enigmail*, can work in combination with [***GNU Privacy Guard***](https://www.gnupg.org/) to use all keys in its "keyring" (or "keychain").

We can let *Mailpile* handle *gpg* to create keys for us and totally manage them, or we can use *gpg* from a terminal window to create keys, import keys, export keys, and also encrypt symmetrically or asymmetrically, sign files, sign other persons' keys...

(I didn't plan to put any *GnuPG* commands in this document, because there are many good tutorials out there, but after mentioning *Mailpile* in an online<=>[air-gapped](#airGapped) workflow, I ended up doing so in an [appendix](#gpgExamples).)

***Mailpile* will be able to use any keys that we might import directly with *gpg* into its keyring.**

<a name="UseSharedGnuPGkeychain"></a>

<div class="fluo_orange_frame">
Please **NOTE** that one of the Security and Privacy settings I [modified above](#SecurityAndPrivacySettingsModifiedFromDefaults) was <u>***Use shared GnuPG keychain for PGP encryption keys***</u> and I activated it.

<u>**I haven't tested at all what happens with "Off", what follows is pure speculation and that setting might even have another meaning.**</u> <span class="fluo_orange_bgnd">**[needs clarification]**</span>

<span class="fluo_orange_bgnd">If you do not want to have anything to do directly with *GnuPG*, you might want to leave that "Off", I don't know if doing so would imply a higher security level. **[needs clarification]**</span>

I prefer to be able to fully use *Mailpile* in combination with *gpg* on the command line.

Besides, in the [GitHub page for *Mailpile* issues](https://github.com/mailpile/Mailpile/issues), I've seen <span class="fluo_orange_bgnd">reports about difficulties to import keys via *Mailpile*'s GUI, while it's trivial to import keys with *GnuPG*'s command line:</span>

`gpg --import filename`

(Those issues may have been solved by now. <span class="fluo_orange_bgnd">**[needs clarification]**</span>)

As for the security level: I prefer to create my own keys apart with GnuPG, I set a stronger passphrase on my keys than *Mailpile*'s current passphrases, alphanumeric instead of numeric-only, and I keep the primary secret key stored apart, I only export secret subkeys and import them into the keychain I actually use. This way, **the primary secret key remains valid as a long-term identity key**, I can always revoke the secret subkeys, periodically or if I think that they might be compromised, and create new ones.

Unless you *really* prepare the whole *Mailpile*+*GnuPG* setup on some [air-gapped](#airGapped) machine, this approach might actually turn out to be weaker than leaving it all to *Mailpile*, because at some point you would have to **type** the keys passphrase, at least twice, once when importing into the keyring, and once for *Mailpile*, and you don't know if those keystrokes are being recorded... This is about **bets**, make yours. If there isn't an option to prepare the whole *Mailpile*+*GnuPG* setup on some [air-gapped](#airGapped) machine (at least for creating keys and moving secret subkeys to a [hardware device](#keysInHardwareDevice)), then leaving it all to *Mailpile* might be the best bet after all.

On the other hand, you'll be typing *Mailpile*'s login password anyway, so the encryption on your local storage might also get compromised... well if somebody's **"watching over your shoulder"**, then simply nothing can be kept secure on that machine, unencrypted or decrypted messages will be exposed as well.  

Better chances of security would be gained by also encrypting/decrypting exclusively on an [air-gapped](#airGapped) machine, better if with a supposedly audited Operative System like *Tails*, especially at the moment of keys generation, to avoid [Kleptography](#Kleptography_NSA).

As for purely brutal force attacks on <span class="fluo_orange_bgnd">the local storage</span> encryption, they wouldn't probably be successful for a few more years.  
<span class="fluo_orange_bgnd">I don't know at the moment what type of encryption it is. **[needs clarification]**</span>  
The current PGP key of *Mailpile*'s developers team is EdDSA, a type of ECC, so maybe the local encryption scheme is also based on ECC. I've quoted something [below](#EdDSA_ECC) about that.

Anyways:

- **If you do leave it all to *Mailpile*, you probably have one more good reason to always keep an updated backup copy of [the whole *Mailpile* folder](#MailpileFolderDefaultLocation) (not only *Mailpile*'s settings backed up via [the *Backup* button](#settingsBackup)), and *also* a backup copy of the *Mailpile* package that you have installed and has been running fine.**  
  <span class="fluo_green_bgnd">Keeping a backup is a good practice anyway, ***Borg*** is a *very* good de-duplicating incremental backup utility, I hear from a very knowledgeable friend that ***Duplicata*** is another good one... or you might just copy the whole folder (in Linux: ~/.local/share/Mailpile).</span>  
   
- **If a frequent backup of the whole *Mailpile* folder is *really* not an option for you for *who knows* what reason:**  
    
    Unless your philosophy is to "read and destroy" received encrypted emails, <span class="fluo_orange_bgnd">you should see if you can backup your secret keys anyway – and not only their passphrase[^MailpileShowsPassphrases] – so you'd still be able to decrypt new incoming messages in case you run into problems with *Mailpile*. I won't investigate for now how to do that in case [that option](#UseSharedGnuPGkeychain) is left "off". **[needs clarification]**</span>

[^MailpileShowsPassphrases] *Mailpile* will show you the passphrases for the keys it is managing for you, in exchange for your *Mailpile* login password:
    - move away or phisically cover all webcams and smartphones cameras around
    - if you don't see an icon with colored envelopes in the upper left corner of the GUI, click the ***Inbox*** tag in the sidebar
    - click the envelopes icon in the upper left corner, you are now accessing a page with your accounts settings
    - click **the small lock icon of the account of which you want to see the keys passphrase**
    - type in your *Mailpile* login password
    
    and you'll see the passphrase that *Mailpile* uses to unlock that account secret keys.  
    If *Mailpile* is using the *GnuPG* keyring, you'll be able to export using *gpg* on the Linux command line (or the Windows cmd window, I guess). The [section](#gpgExamples) about *GnuPG* [mentions exporting secrets from the keyring](#ExportingSecretsFromKeyring), but there are also many good tutorials on the web.

I describe [below](#keysInHardwareDevice) how I handled secret keys for a *Yubikey 5 NFC*.
</div>

<a name="TypesOfKeys"></a>

## Types of keys

Keys can be of different **types**. Compatibility with Autocrypt mentioned below is "as far as I've read", it could be outdated info (but <span class="fluo_green_bgnd">a few tests</span> are enough to understand that it is a secondary importance matter):

- **EdDSA256**, compatible with Autocrypt 1.1, which means that even the message subject will be encrypted, thus limiting the amount of data left visible by SMTP, the Send Mail Transfer Protocol[^draftForEvolutionOfSMTP]
- **RSA3072**, compatible with Autocrypt 1.0
- **RSA4096**, not compatible with Autocrypt... but when testing I see that <span class="fluo_green_bgnd">both *Mailpile* and *Thunderbird*+*Enigmail* circumvent the problem, only showing **"(Subject unavailable)"** or **"..."** as the email subject once it has been encrypted, revealing the original subject at the moment of decryption</span>. A correspondent using a client not implementing the same workaround would be able to read the subject anyway at the beginning of the message body, once decrypted.  
  In any case: we can always arrange to write generic/allusive subjects not needing encryption.

[^draftForEvolutionOfSMTP] *Mailpile* developers already have a draft for an evolution of SMTP, just *great*.


<a name="ImayChoseRSA4096despite"></a>**Please share** if you have more information to evaluate for this choice.

<span class="fluo_green_bgnd">**I may choose RSA4096** as the basic key type associated with an account</span>, considering – and <span class="fluo_green_bgnd">*despite*</span> – what follows, and considering the recommendations I've found in various **tutorials** about creating *GnuPG* keys, [one](#perfectKeypair) is mentioned in the [appendix with examples of usage of *GnuPG* in a *Linux* terminal command line](#gpgExamples).

After reading below about [Kleptography](#Kleptography_NSA), you'll wonder, as I do:

<center>Were the tutorials I've seen made by backdoors creators pushing their trojan horses?  
I don't think so,  
but the truth is:  
<big>**I don't know**</big>[^HowWouldYouKnow]</center>
  
[^HowWouldYouKnow] Was this one? I know it wasn't, but how would you know? LOL this reminds me of certain spy movies where nobody can trust anybody.

Let's see what Glenn Greenwald uses[^whereDidIFindGreenwaldKey], I guess he learned from Edward Snowden:[^heLearnedFromSnowden]

[^whereDidIFindGreenwaldKey] I went to [one of many](https://keyserver.escomposlinux.org/) key servers out there and as search string I typed Glenn Greenwald.  
  Each one of this servers may not always be up and working correctly. If you get errors like "Bad Gateway" when clicking on a key ID to actually get the key, you may want to wait a few seconds and retry. If you have the hexadecimal key ID, it is also possible to import directly into gpg, for instance in this case:  
  
        gpg --keyserver keyserver.escomposlinux.org --receive-keys 0xA4A928C769CD6E44
  
    (Of course you would replace the server URL and key ID.)

[^heLearnedFromSnowden] I've read that at first Greenwald was deeming as too complex the security procedures that Snowden was asking from him. He was later convinced by Laura Poitras, the author of the documentary ***Citizenfour*** (2014).

```
pub   rsa4096/0xA4A928C769CD6E44 2015-01-06 [SCA] [expires: 2021-01-19]
      734A3680A438DD45AF6F5B99A4A928C769CD6E44
uid                   [ unknown] Glenn Greenwald <Glenn.Greenwald@theintercept.com>
uid                   [ unknown] Glenn Greenwald <Glenn.Greenwald@riseup.net>
uid                   [ unknown] Glenn Greenwald <GlennGreenwald@firstlook.org>
uid                   [ unknown] Glenn Greenwald <Glenn.Greenwald@firstlook.org>
sub   rsa4096/0x30B33AC842F37B85 2015-01-06 [E] [expires: 2021-03-05]
```

That's one point for RSA4096.

And another one: *Mailpile* developers themselves qualify as "strong" the RSA4096 key type in that pull-down menu, meaning that they don't have elements against RSA4096 either (and they seem to know what they are doing, *Mailpile* can actually use or not use the pre-installed gpg-agent and gpg binary).

Now one point less for EdDSA:

<a name="EdDSA_ECC"></a>
This page tells us that **EdDSA is based on elliptic-curve cryptography**:  
[**EdDSA** – https://en.wikipedia.org/wiki/EdDSA](https://en.wikipedia.org/wiki/EdDSA)  
Such encryption, with shorter keys, might be as hard to break as RSA encryption with larger keys... **except for quantum computing attacks**.

Let's quote from this other page (please visit the page to also read those footnotes):  
[**Elliptic-curve cryptography** – https://en.wikipedia.org/wiki/Elliptic_curve_cryptography](https://en.wikipedia.org/wiki/Elliptic_curve_cryptography)

> **Quantum computing attacks**
>
> Shor's algorithm can be used to break elliptic curve cryptography by computing discrete logarithms on a hypothetical quantum computer. The latest quantum resource estimates for breaking a curve with a 256-bit modulus (128-bit security level) are 2330 qubits and 126 billion Toffoli gates.<sup>~~~[43]~~~</sup> In comparison, using Shor's algorithm to break the RSA algorithm requires 4098 qubits and 5.2 trillion Toffoli gates for a 2048-bit RSA key, <span class="fluo_green_bgnd">suggesting that ECC is an easier target for quantum computers than RSA. All of these figures vastly exceed any quantum computer that has ever been built, and estimates place the creation of such computers as a decade or more away.</span>[citation needed]
>
> Supersingular Isogeny Diffie–Hellman Key Exchange provides a post-quantum secure form of elliptic curve cryptography by using isogenies to implement Diffie–Hellman key exchanges. This key exchange uses much of the same field arithmetic as existing elliptic curve cryptography and requires computational and transmission overhead similar to many currently used public key systems.<sup>~~~[44]~~~
>
> <span class="fluo_green_bgnd">In August 2015, the NSA announced that it planned to transition "in the not distant future" to a new cipher suite that is resistant to quantum attacks. "Unfortunately, the growth of elliptic curve use has bumped up against the fact of continued progress in the research on quantum computing, necessitating a re-evaluation of our cryptographic strategy."</span>


<a name="HigherSecurity"></a>

## Higher security: superposing encryption levels

Whatever setup we have chosen now, if in the future we need a higher security level on some emails we can superpose one or more encryption steps.

- **we create apart another key** (primary + subkeys), our correspondent does the same  
    
    "apart" meaning possibly on *Tails* (see **Kleptography** [below](#Kleptography_NSA)), because *GnuPG* on *Tails* should undergo stricter auditing than for instance on *Ubuntu* and *Windows*[^moreEntropy], it could be an [air-gapped](#airGapped) computer or the keys could stay on a [hardware device](#keysInHardwareDevice)  
    
- **we encrypt apart** using *gpg* command line, with the --armor option
- **we paste the result** of the encryption into our email body **or attach it** (in which case better avoid the --armor option not to unnecessarily inflate size), so our message will be **encrypted twice** with two different keys (or more than two).

[^moreEntropy] Months ago I would have added: "... and because by default *GnuPG* on *Tails* adds to the randomness more entropy created from keyboard and mouse events". But I have recently created keys on *Ubuntu* (ver. 18.04.5 with *GnuPG* ver 2.2.4 and libgcrypt 1.8.1) to simply check the syntax of a few commands I've added to the [*gpg* appendix](#gpgExamples), and it's quite possible that the random generator was *waiting* for such events while giving out small chunks of the output sequence of the required size.

This is not difficult at all, at least on any *Linux*-based machine (I can only guess that *gpg* takes the same command line syntax in *Windows*). Just check out the [appendix on *GnuPG*](#gpgExamples), especially [this part ](#EncryptingSigning).

<a name="otherCommTools"></a>

## Other communication tools than email

The "encrypt apart and attach or copy&paste" modus operandi opens the possibility to use *GnuPG* to add secrecy to other communication channels instead of e-mail, e.g. *Threema* via [web.threema.ch](https://web.threema.ch) or *Signal* via its desktop app (without forgetting that our smartphones are probably the least secure devices around), or maybe [Element](https://element.io/), which is mentioned in this [interesting page on privacytools.io](https://www.privacytools.io/software/real-time-communication/). Without forgetting that *GnuPG* doesn't support [forward secrecy](#forwardSecrecy).  

<a name="keysTheft"></a>

## Keys theft

After plainly stealing my secret keys *from storage space*, the attacker should *crack* its encryption. I'm setting *strong passphrases*, but today's computers are increasingly fast (and keystrokes could be monitored/recorded).

<a name="keysInHardwareDevice"></a>

## Keeping secret subkeys on a hardware device

<div class="fluo_green_frame">**DISCLAIMER:** I'm not getting *any compensation whatsoever* from *Yubico* (alas LOL), I'm just sharing possibly useful info. This device happens to be the one I *bought*, I can't say anything about any others.
</div>
<p></p>
<div class="fluo_green_frame">**CAVEAT:** Keeping secret subkeys on a hardware device is probably pretty good against keys theft and should grant that what's *signed* with your signing subkey is actually signed *by you*.

**As for secrecy:**

- again, the fact that they can't steal your secret subkeys prevents that they can use them elsewhere at will
- **BUT**
    - your non-encrypted content is still on a non-air-gapped machine in some moment
    - your non-encrypted content is *passing to/from the hardware device through a USB port*, which could be the target of a bad USB exploit.

So, again, I'm afraid that this is about odds and bets and actually guessing.  
And again: letting *Mailpile* manage your secret keys might also be a good bet after all, or not using a hardware device to keep your keys (lacking certainties, I'm offering a honest analisys, so you can at least *evaluate* what this is about).
</div>

To prevent **keys theft**, an increased level of security would be **a hardware device holding the secret subkeys**, hoping that the device has no back doors.  
Using a hardware device wouldn't necessarily prevent a [side channel attack](https://en.wikipedia.org/wiki/Side-channel_attack)... or it possibly would on older PCs, provided they're not phisically exposed to anybody else but the owner.  
  
Personally, after reading plenty of articles and posts in forums about discoveries of vulnerabilities apparently built in on purpose, I tend to think that the most recent is the hardware you buy from certain brands the most likely it is to come prepared with all sort of tricks to steal your data.

On a *Yubikey 5 NFC* (or *Yubikey 5 Nano*) you'd have to type in the device PIN[^Yubikey5PIN] only once in a while[^newFunctionRequiresTouch] *and* touch its sensor button (or touch sensitive part) for *any* single operation required from it. Disabling this request would decrease the level of security against remote hackers, who might possibly be able to decrypt, encrypt or sign something with your secret subkeys, but still, they wouldn't be able to steal them.  

[^newFunctionRequiresTouch] As far as I can tell (I haven't dug): you are asked the PIN each time you use another subkey, or if many hours – possibly configurable – have elapsed since the last time you used that subkey (I don't know if keeping using it would extend the grace period indefinitely). For instance, if you have typed in the device PIN to *sign* something, you have only unlocked the use of the signing subkey. If right afterwards you want to use another subkey, e.g. to decrypt, you'll be asked the PIN again. After having enabled each function, the device can stay ON for quite a few hours – if you wish so – and later perform more such operations only requiring your touch on the sensor button.

<div class="fluo_green_frame">I've given a try at this *Yubikey 5 NFC* with *Mailpile* and it works fine (actually *Mailpile* works with *GnuPG* which in turns handles the *Yubikey* nicely).

**Unfortunately** the device can only hold one PGP credential.[^upTo3subkeys] If you need *separate* email accounts, you'll have to choose one and keep your other secrets in the gpg keyring as usual. If you don't care if the same *GnuPG* keys are used with various email accounts/addresses, then plenty of tutorials out there will tell you how to use *GnuPG* on the command line to add more than one user id to the same key (basically `gpg --edit-key <keyID>` then `adduid` then `save`).

Or you can use the key you store on the hardware device as described above, as [an additional encryption level](#HigherSecurity), pasting/attaching to an email which is *also* going to be encrypted with the key associated to that account.

(A higher security level would be encrypting and decrypting on an [air-gapped](#airGapped) machine with keys which secret part never leave that machine, they'd only be stored in the encrypted USB flash drive from which you exclusively boot that machine, and possibly in its backup copy also "touching" only the air-gapped machine.)
</div>

[^Yubikey5PIN] It can actually be an alphanumeric passphrase up to 127 characters long, if the information I recollected is correct.


[^upTo3subkeys] With up to three subkeys, which means that it could also be used to authenticate in SSH connections, but as I just said, it can only hold one PGP credential (it can hold up to 25 credentials or infinite number of credentials of other standards of which I'll use zero to three credentials at most).

<a name="CreatingKeysMovingToHwDevice"></a>

### Creating keys and moving them to the hardware device

Here you have a couple of tutorials I read for this *Yubikey 5 NFC*:

- [**Use A YubiKey For PGP Signing, Encryption, And Authentication** — The Polyglot Developer](https://www.thepolyglotdeveloper.com/2019/02/use-yubikey-pgp-signing-encryption-authentication/)
- [**How to use GPG with YubiKey (bonus: WSL 1 and WSL 2)** — The Coding Nest](https://codingnest.com/how-to-use-gpg-with-yubikey-wsl/)

A summary of the workflow I followed:

- I also created these keys+subkeys apart, as usual, not on the machine I use online. And **I didn't let the *Yubikey* create any *PGP* keys** because otherwise there would be no way to have a backup, as the device is supposed to never give out your secrets.[^MCU]
- Then I only exported the secret subkeys (not the primary key) with something like this:
  
        gpg -o SECRET_SUBKEYS --export-secret-subkeys my_email@addr.ess
  
- Still on the offline machine, I imported them into another keyring (probably an unnecessary precaution), something like this:  
    ```
    cd
    mv -i .gnupg .gnupg_before
    install -d -m 700 .gnupg
    gpg -k
    gpg --import SECRET_SUBKEYS
    ```
- Still on the offline machine, **following the two tutorials mentioned above**:
    - **I setup strong PINs** (actually passphrases) on the *Yubikey* (closed cameras around, accurately wrote on paper first, no cameras around, and typed after)
    - I moved those secret subkeys to the *Yubikey* and set it as follows:  
        - Sensor button touch required to encrypt/decrypt/sign
        - NFC disabled for *all* credential types, it means Near Field Communication, because:
            - my smartphone doesn't support it
            - I think I won't buy another [fourth] Android phone *ever again*, after the tracking-you-as-per-Trilateral-Commission-under-Covid-19-pretext API was installed without asking for permission
        - Entirely disabled support for credential types I'm not using
- I exported the *public* key and moved only the *public* key to the machine I use online, with something like this:
  `gpg -o PUBLIC_KEY --export my_email@addr.ess`
- Finally I *only* imported the public key into the *GnuPG* keychain on this actual destination machine, hence it could never see those secret subkeys:  
  `gpg --import PUBLIC_KEY`
- After finishing it all, **back to the offline machine**:  
    ```
    cd
    srm -rf .gnupg
    mv -i .gnupg_before .gnupg
    ```

If using the [***Yubikey Manager***](https://www.yubico.com/products/services-software/download/yubikey-manager/)[^YubicoSignatures] is a problem on the offline machine, you can leave the last steps for the destination machine before going back online, but with the offline machine you'll have already set up on your *Yubikey* three strong PINs (or passphrases) after writing them down on paper (no cameras around), one for normal operations, one as admin, one to reset it and unblock it after submitting a mistyped PIN three times. (On the online machine, I'd uninstall the Yubikey Manager, just not to leave it there ready and tempting any intruding hackers to spend additional time messing around.)

[^YubicoSignatures] It is good practice to check sensitive software you download with the developers' signatures.  
    In this document you have [an appendix with examples of *GnuPG* usage](#gpgExamples) on a *Linux* terminal command line, also showing [how to create and verify detached signatures](#DetachSig).  
    
    As it has [already been reported](https://github.com/Yubico/yubikey-manager-qt/issues/248), **in case any piece of software coming from *Yubico* has been signed with a key which hexadecimal ID you don't find on their [Software Signing page](https://developers.yubico.com/Software_Projects/Software_Signing.html)**, you can search for that ID here [**https://keys.openpgp.org/**](https://keys.openpgp.org/) where you should find a primary key ID and a name. Then, you check that the name and key ID are actually listed on their [**Software Signing page**](https://developers.yubico.com/Software_Projects/Software_Signing.html).
    (Maybe *Yubico* staff will improve this aspect of their website as suggested in that GitHub issue and you won't have to lose extra time when verifying any of their signatures.)


It looks more complicated than it is (of course it requires attention).

<span class="fluo_green_bgnd"><a name="amIBeingTooParanoid"></a>**Am I being too paranoid?**</span> **I *was* believing so, before coming to know what's mentioned below about ["air-gapped"](#airGapped) (especially [this part](#BeamAndCoating) of [this footnote](#neverTooParanoid)), and before what happened days ago, two different "weird" facts in the same day:**

<a name="hackersVisit_symptomA"></a>

#### Possible attack, symptom A

<span class="fluo_green_bgnd">Hours after a successful operation, I found the *Yubikey*'s PIN blocked</span>, supposedly meaning that 3 attempts with a wrong PIN had been made (but of course I hadn't omitted setting up different PINs/passphrases than the default ones).

<a name="UnblockingYubikey"></a>

### Unblocking the *Yubikey* after repeated introduction of the wrong PIN/passphrase

In such cases, here is how to unblock the device normal operations PIN (that's what I did with this *Yubikey*).

<p class="fluo_green_frame">EACH ONE OF THE FOLLOWING COMMAND LINES HAS TO BE TERMINATED WITH THE \<ENTER\> KEY.</p>

``` 
gpg --edir-card
admin
help
``` 

choose the menu item which enables you to unblock the normal PIN using the reset one, with this *GnuPG* version (2.2.4):

``` 
unblock
``` 
to exit:
``` 
quit
``` 

Now, I'm keeping the device plugged into **a HUB with real mechanical switches to cut power to any of its USB slots**. The idea is to leave that switch off unless necessary. Apparently, the device works just fine also via the HUB, I've tested signing some 1.9 GB files and it worked flawlessly. If you do that, ***before* you try to use the *Yubikey*, be sure that its USB slot is switched ON**.[^forgotToSwitchOnHUBslot] 

[^forgotToSwitchOnHUBslot] Actually, **if you forget** to switch on the HUB slot before trying to use the *Yubikey*, you are normally simply invited to plug in the device. So far (about 40 days of everyday usage), only twice I went into a bit of a trouble and kept getting errors from *GnuPG* after switching the slot on.  
  **In case**, try unplugging the HUB from your PC and plugging it in again (*or* plugging the *Yubikey* into a non-HUB USB port, using it once, then back to the HUB, but I think the first one is the way to go, at least on this *Linux* PC).

<a name="hackersVisit_symptomB"></a>

#### Possible attack, symptom B

[**The same day**](#hackersVisit_symptomA), <span class="fluo_green_bgnd">I couldn't eject an USB flash drive, *Linux* kept warning that the device was busy</span> while I was closing anything else. Finally, it turned out that I could unmount it with no warnings only after closing the last thing I would have deemed responsible, <span class="fluo_green_bgnd">the *Firefox* browser instance I had been using to surf the web</span>, despite the fact that I hadn't accessed that USB flash drive at all from Firefox and despite having launched *Firefox* inside firejail (I'll have to review the apparmor and firejail profiles).

<span class="fluo_green_bgnd">**Apparently, you are never too paranoid.**</span> And **BTW:** 

<a name="separateFirefoxInstance"></a><div class="fluo_green_frame">I use a separate *Firefox* instance to connect to *Mailpile*, I do not surf the web *and* connect locally to *Mailpile* with the same *Firefox* instance. The one-line bash script I use to launch *Firefox*:

    firefox -ProfileManager -no-remote -new-instance "$@"

If you are running out of RAM space, you might possibly save a bit of it by omitting the -no-remote option, with **decreased security level** though.

Supposedly more secure:

    firejail firefox -ProfileManager -no-remote -new-instance "$@"

Or you could use a browser, e.g. *Vivaldi*, to surf the web and another, e.g. *Firefox*, to connect to *Mailpile* on your computer, or the other way around.
</div>

[^MCU] It contains a microcontroller who is supposed to do all operations. I want to believe that these devices are so highly audited and kept under observation worldwide that putting a backdoor into them would be highly risky for who did it, legally and not, and for a whole lot of countries by now. *Yubico* however, if I've read correct information, admitted some kind of vulnerability of a "FIPS" series which was actually supposed to have some stronger US Federal certification, and retired the vulnerable model replacing it for customers.

<a name="KeepingSecretsStoredApart"></a>

## Keeping secret subkeys stored apart and making them available when necessary

I've also tested ***not* keeping in the *GnuPG* keyring the keys for the accounts I've configured in *Mailpile* until necessary**. Luckily, *Mailpile* does not complain about a symlinked ~/.gnupg folder (*GnuPG* detects keyring changes and asks for your passphrases again).  
My conclusion for now, for this trick not to have *Mailpile* complain and possibly create new keys if you pass through the settings of an account (even if only servers related settings):  

<div class="fluo_green_frame">When *Mailpile* is running, keep in the keyring *at least* the *public* keys of the accounts you have configured in *Mailpile*.  

Before modifying an account settings – and obviously before doing anything requiring signing, encrypting, decrypting – make the secret keys available.[^forgotToMakeSecretKeysAvailable]

</div>

[^forgotToMakeSecretKeysAvailable] **If you forget to make secret keys available before opening an encrypted message**, *Mailpile* might later remember that it had no suitable secret keys to decrypt it, despite the fact that afterwards you might have made those keys available and sometimes even despite having shut down down and restarted *Mailpile*. In case, **try moving that message to another tag (and back if you need)**. Once, so far, that has not worked here.  
  (Opening the Security settings of that account and pressing the ***Save*** button – after checking that the correct key was appearing – didn't solve it either.)  
  But **I was able to decrypt that email again – and see it "green" again – minutes later after sending another email using the same secret keys**.

<a name="OverYourShoulder"></a>

## Over your shoulder

<u>**Remember:** apart the chance that the encryption scheme itself gets compromised in the future, or your keys get stolen and their passphrase cracked, there's also the chance that your computer itself might be compromised, with somebody watching "over your shoulder", no matter how secure your login and keys passphrases are.</u>

Of course it also depends on the level of security you need. Protecting from common criminals is not the same as being a journalist whose sources are up against 9-11'ers.

But at least *slowing down* possible bad guys in general is an important step that worldwide citizens should all take.

You might also need to warn someone, e.g. police forces somewhere in the world, that by analyzing certain news it seems possible that something bad might happen, and you would not want to risk giving out that idea to the bad guys in case it turns out that they hadn't actually thought about it. But it doesn't look like police forces in general, as well as journalists in general, are nowadays "encryption aware" (not that mainstream journalists are up against the "biggest" bad guys around, anyways, it looks more like the opposite... but I was thinking about *real* journalists).

<a name="airGapped"></a>

## "Air-gapped"

Staying offline while decrypting and reading a message doesn't guarantee that it will remain secure once you get back online, even if you have securely deleted the unencrypted message. The same consideration is valid for any password you type on your computer, even if used locally.

Edward Snowden was asking Glen Greenwald to only decrypt/encrypt on an air-gapped machine certain messages.  
That could be for instance:

- an old laptop booting *Tails* from a USB flash drive
- never again to be connected to any other machine or directly to the Internet
- from which you will have pulled out the WiFi module
- no USB devices to be shared ever with other machines
- data only passing screen-to-cam with QRcodes or via CD/DVD
- shielded room = better, radio waves could vehicle not only information but also malign code (too paranoid?[^neverTooParanoid])  
- <a name="phonesWithFMradio"></a>smartphones with FM radio to be kept as far as possible or in a metallic box

[^neverTooParanoid] I <a name="neverTooParanoid"></a>find it interesting to analyze and progressively adopt better habits (keeping in mind that our devices and OS'es are so insecure), as if I were handling something worth anybody's efforts to steal or alter, like industrial or military secrets, or the communications of a congressman or minister.  
    The more I know, the more I'm convinced that **you're never too paranoid**.
  
    Just consider:
    
    - **Kleptography**, developed [above](#Kleptography_NSA), while here we can elaborate on:
    
    - **Radio <a name="BeamAndCoating"></a>communications.** Here are a few lines from "The Perfect Weapon (2020)" (in my opinion an interesting piece of Russophobic Chinophobic Iranophobic propaganda, possibly manufactured by the Deep State / NWO powerful media producing facilities, with a limited hangout when it recognizes "<u>*we*</u> started the cyber war"):
      
        At about 3min44s, telling about the StuxNet computer virus:
        
        > John Hultquist: the plan was a piece of malaware would be delivered into the industrial control systems running the Iranian nuclear program.
        >
        > Michael Riley: this network was <span class="fluo_green_bgnd">air gapped</span>. In other words, it's not connected to the internet.
        > So you had to have ways in which the code could jump onto those computers.
        >
        > Sanger:
        > there's still some mystery about exactly how this code
        > made it from the nsa and the israeli cyber unit
        > into the natanz plant.  
        > There are many ways, including slipping in a usb key.  
        > But we also now know that <span class="fluo_green_bgnd">the NSA had designed a brilliant small system, about the size of a briefcase, that could work from six or seven miles away, beaming computer code into a computer that had been set up with a receiver chip.  
        > And that device could be used not only to put code in, but later to replace it and update it.</span>  
        >
        > Hultquist: once they got in, the code started unlocking itself, and it started two major tasks.  
        > The first one was to record everything that the operator would be saying, and essentially, put that on a loop.  
        > So that every day, when the operator came in to work, everything would look just fine.  
        > It's sort of like a classic heist movie where the surveillance video is run on a loop, and the guard never knows what's actually going on. While at the same time, somebody's breaking in and stealing something.  
        > The iranians were thinking the whole time that they're making progress, that they're moving towards their goal, when in fact, these systems are deadlined.  
        > Because the second task for the code was to take the centrifuges and break them.
        
        At about 1h15m50s, telling how they analyzed photos found hacking a chinese PC:
        
        > There was a picture of this big white building behind him, that had huge antennae dishes, had <span class="fluo_green_bgnd">reflective coating on the windows, that would prevent signal interception</span>.
  
    As for the question "am I being too paranoid?", apart from radio waves, I had already mentioned a [blocked *Yubikey* PIN](#hackersVisit_symptomA) and a [firejailed *Firefox* instance engaging a USB flash drive](#hackersVisit_symptomB).


Why the last point? Quote from [**​How to Build a Raspberry Pi FM Transmitter** – Circuit Digest](https://circuitdigest.com/microcontroller-projects/raspberry-pi-fm-transmitter):

> <span class="fluo_green_bgnd"">Every microprocessor will have a synchronous digital system associated with it which is used to reduce the electromagnetic interference. This EMI suppression is done by a signal called Spread-spectrum clock signal or SSCS for short. The frequency of this signal can vary from 1MHz to 250MHz</span> which luckily for us falls within the FM band. So by writing a code to perform frequency modulation using the spread-spectrum clock signal we can tweak the Pi to work as a FM transmitter.

<span class="fluo_green_bgnd"">If it can transmit radio frequency in a controlled manner, it can transmit data as well (with FM modulation or not).</span>


When it comes to hardware, I tend to think:

- "more recent" = "more chances that the hardware has been prepared for certain tricks" (sad to say, also considering energy consumption)
- certain manufacturers of CPU and chipsets are named more frequently than others in the reports of vulnerabilities which seem to have been built in on purpose, I guess if you follow the money you find out that certain State actors are involved, and I'm not thinking China
- it's plausible that the radio-waves related "vulnerabilities" are not discovered as frequently as others, or not until too late (see this [previously inserted footnote](#neverTooParanoid))

**Closing any sensitive piece of paper before opening any cameras around is a necessary precaution, also for any not air-gapped setup.**

<a name="Kleptography_NSA"></a>
<div class="fluo_green_frame">**ATTENTION:** encrypting/decrypting staying air-gapped might not prevent certain tricks, for instance:

**Radio communications:** see [just above here](#phonesWithFMradio) and again this [previously inserted footnote](#neverTooParanoid).

**[Kleptography](https://en.wikipedia.org/wiki/Kleptography):** for instance **not a truly random or pseudo-random generator at the moment of the creation of your keys**.  
  The NSA was accused to have pushed a tricky algorithm as a commercial standard.

[**Dual_EC_DRBG** – Wikipedia](https://en.wikipedia.org/wiki/Dual_EC_DRBG)  

> [...] In 2013, The New York Times reported that documents in their possession but never released to the public "appear to confirm" that the backdoor was real, and had been deliberately inserted by the NSA as part of its Bullrun decryption program. In December 2013, a Reuters news article alleged that in 2004, before NIST standardized Dual_EC_DRBG, NSA paid RSA Security $10 million in a secret deal to use Dual_EC_DRBG as the default in the RSA BSAFE cryptography library, which resulted in RSA Security becoming the most important distributor of the insecure algorithm. [...]

This is why I've written "I _may_ choose", "I'd still choose...", <span class="fluo_green_bgnd">of course I feel uncomfortable when opting for RSA4096 after reading this</span>.

I'd be *willing* to at least *hope* that these algorithms are somewhat audited by knowledgeable persons worldwide, which is probably why they got caught... although *years later*, but the truth is:  

<center><big>**I don't know**</big></center>

<span class="fluo_green_bgnd">For important messages, we might want to **[superpose encryption levels](#HigherSecurity) made with keys of different types.**</span>

Are "RSA Security" really the guys who created the RSA standards used by *GnuPG*?  
[**RSA Security** – Wikipedia](https://en.wikipedia.org/wiki/RSA_Security)

> [...] RSA is known for allegedly incorporating backdoors developed by the NSA in its products. [...]

Yes, it's definitely them.

Well, if I were a lawyer, I'd probably think that opting for RSA4096 as the basic key associated to an account, in case of any backdoors at least they wouldn't exploit my customer's messages legally, because that would make public the existence of a backdoor.  
Also, I don't know if there wouldn't be any backdoors with EdDSA or any other standard.

To be fair, however, I think these algorithms and their implementation is open to auditing by anyone having the time and knowledge to do it... and *GnuPG* binaries can be [downloaded](https://www.gnupg.org/download/index.html) with [signatures](#gpgExamples) (it seems to be kind of circular, using *GnuPG* to verify *GnuPG* pre-compiled binaries, but you might use an audited version to verify the signature on the new one, at least you know that it is what the developers published).
</div>

Moving data air-gapped <=> not air-gapped is a PITA of course, given that USB is a big no no.[^badUSBexploit] The smaller the data file is, the faster it is to pass it screen-to-cam fragmented in QRcodes (I've made myself a couple of scripts which do that, TX/RX screen-to-cam). More than a few tens of kBytes => it's probably faster to burn a rewritable CD or DVD.

[^badUSBexploit] Apparently, the hardware of USB ports is too flexibly reprogrammable, it can be used to steal information (maybe it's more difficult with *encrypted* USB volumes). Such attacks go under the common denomination of "bad-USB exploit".


<a name="PerfectlySuitable"></a>

## *Mailpile* perfectly suitable if you also need to decrypt/encrypt apart

**You might check out the [appendix with examples of *GnuPG* usage in a *Linux* terminal window](#gpgExamples).**

It's easy to add to a *Mailpile* message some data encrypted apart, you can simply attach the encrypted file to your email.

If your encryption result is in ASCII format, you can also paste it into the email body, but in case it is a long message, the extraction of your encrypted data to be decrypted offline might not be straightforward, depending on your correspondent's skill level and email client.

***Mailpile* is perfectly suitable for the "extraction" of a message that you might need to decrypt apart possibly after having moved it to another machine.**

Its Command Line Interface enables to **export** more than one message at a time, you might want to check out the specific [section](#Mailpile_CLI) of this document about that.

The GUI enables to easily save a message body or the whole message format.

<a name="saveMessageBody"></a>You can save the message body to your browser downloads folder, after activating ***Display HTML formatted message content***:

<a name="imageWithEyeIconFrame_A"></a>*image 16b*  
![img 16b](pictures/mailpile__img_016b.jpg)  
*(About the picture: a few days have passed since I took the other snapshots in this tutorial, I've received a few more emails and I might have added a couple of tags.)*

Or if you need the email source code with its entire format, you can **hover** the mouse cursor as in the following picture to reveal more functionalities:

<a name="imageWithEyeIconFrame_B"></a>*image 16c*  
![img 16c](pictures/mailpile__img_016c.jpg)

**Clicking that small hammer icon**, which mouse hover hint says ***Display message source code***, will open a new tab in your browser, with the whole message as received.  
You can then save that tab content to a file (ctrl-s with *Firefox* in English).

</div>
