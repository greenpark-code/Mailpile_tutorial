- [**Disclaimers**](#Disclaimers)
- [**Introduction**](#Introduction)
    - [**Breakthrough**](#breakthrough)
    - [**Open issues**](#OpenIssues)
    - [**Non-issues to be aware of**](#notIssuesToBeAwareOf)
    - [**Wish List**](#WishList)
        - [**In lists of emails**](#InListsOfEmails)
    - [**Encryption made easy for non-tech savvies**](#EncryptionMadeEasy)
    - [**Tags**](#Tags)
    - [**Design**](#Design)
    - [**Easy installation and setup**](#EasySetup)
    - [**Multiple email accounts**](#MultipleAccounts)
- [**Hands-on session**](#HandsOn)
    - [**Starting *Mailpile***](#StartingMailpile)
    - [**First-time setup**](#FirstTimeSetup)
- [**About keys and security – not essential to use *Mailpile***](#AboutKeysAndSecurity)
    - [**Types of keys**](#TypesOfKeys)
    - [**Higher security: superposing encryption levels**](#HigherSecurity)
    - [**Other communication tools than email**](#otherCommTools)
    - [**Keys theft**](#keysTheft)
    - [**Keeping secret subkeys on a hardware device**](#keysInHardwareDevice)
        - [**Creating keys and moving them to the hardware device**](#CreatingKeysMovingToHwDevice)
            - [**Possible attack, symptom A**](#hackersVisit_symptomA)
        - [**Unblocking the *Yubikey* after repeated introduction of the wrong PIN/passphrase**](#UnblockingYubikey)
            - [**Possible attack, symptom B**](#hackersVisit_symptomB)
    - [**Keeping secret subkeys stored apart and making them available when necessary**](#KeepingSecretsStoredApart)
    - [**Over your shoulder**](#OverYourShoulder)
    - [**"Air-gapped"**](#airGapped)
    - [***Mailpile* perfectly suitable if you also need to decrypt/encrypt apart**](#PerfectlySuitable)
- [**Back to our hands-on session**](#backToHandsOn)
    - [**Accessing an email account**](#accessingEmailAccount)
    - [**More accounts**](#MoreAccounts)
        - [**Copy of the remote folders structure and content is accessible in the sidebar**](#CopyOfTheRemoteFoldersStructureInSidebar)
        - [**Configuring *Google Mail* accounts in *Mailpile***](#MailpileWithGMail)
    - [**Moving emails to the trash**](#MovingEmailsToTheTrash)
    - [**Using tags**](#UsingTags)
        - [**Creating a tag**](#CreatingATag)
        - [**Moving emails to a tag**](#MovingEmailsToATag)
        - [**Organizing Your Sidebar**](#OrganizingSidebar)
        - [**Editing tags settings**](#EditingTagsSettings)
    - [**Logout + shutdown or directly the latter**](#LogoutShutdownOrDirectlyShutdown)
    - [**Backup of *Mailpile* settings**](#BackupOfMailpileSettings)
    - [**Tags as attributes**](#tagsAsAttributes)
    - [**Nested tags (subtags)**](#nestedTags)
        - [**(Tag Automation)**](#tagAutomation)
    - [**Removing tags from emails**](#removingTagsFromEmails)
    - [**Composing and sending an email**](#ComposingAndSendingAnEmail)
- [**The Command Line Interface (CLI) – not essential to use *Mailpile***](#Mailpile_CLI)
    - [**Clearing the CLI space**](#clearingTheCLI)
    - [**Getting help, switching output format**](#GettingHelp)
    - [**Searching, exporting emails**](#SearchingExporting)
        - [**Setting the number of results per page**](#SettingNumOfResultsPerPage)
        - [**Changing sort order of search results in the CLI**](#ChangingSortOrderCLI)
    - [**Definitive deletion of emails**](#deletingEmails)
        - [**In the GUI: enabling deletion of emails**](#EnablingDeletion)
        - [**In the GUI: setting the number of days in the trash before automatic definitive deletion of emails**](#SettingDaysInTrash)
        - [**Immediately emptying the trash (or part of it) using the CLI**](#ImmediatelyEmptyingTrash)
    - [**Tagging and untagging emails using the CLI**](#TaggingUntaggingUsingTheCLI)
        - [**Moving emails to the trash using the CLI**](#MovingToTheTrashUsingTheCLI)
        - [**Moving emails out of the trash using the CLI**](#MovingOutOfTheTrashUsingTheCLI)
- [**Appendix: a few examples with *GnuPG* on the command line – not essential to use *Mailpile***](#gpgExamples)
    - [**Listing the public keys in the keyring**](#ListingPubKeys)
    - [**Listing the secret keys in the keyring**](#ListingSecretKeys)
    - [**Exporting a public key from the keyring**](#ExportingPubKey)
    - [**Exporting secret keys or subkeys from the keyring (not if held in a hardware device)**](#ExportingSecretsFromKeyring)
    - [**Importing public or secret keys or subkeys or a revocation certificate**](#Importing)
    - [**Encrypting, signing**](#EncryptingSigning)
    - [**Decrypting**](#Decrypting)
    - [**Creating a detached signature and verifying one**](#DetachSig)
    - [**The term "signature" is possibly confusing**](#TextSignatureAtTheBottom)
    - [**Temporarily using another keyring**](#TemporarilyAnotherKeyring)
    - [**Before signing somebody else's keys...**](#BeforeSigningKeys)
- [**NOTES**](#__footnotes__)
