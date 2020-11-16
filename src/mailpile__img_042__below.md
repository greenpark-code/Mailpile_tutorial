The file is actually there.  
**Its contents are encrypted. However, you never know... I prefer to store it away.**

<a name="handlingSensitiveFiles"></a><div class="lightblue_frame">**TIP:**

- **copy, do not move** a sensitive file to a safe place, e.g. an encrypted USB flash device (you can also encrypt the file itself with *gpg*)
- **then, securely delete** the file from your PC.  
  On *Linux* and MacOS you can use cp (not mv), then you can use the `srm filename` command in the terminal window (**secure-delete** is the name of **the package including srm** in *Linux* distributions derived *Debian*, like *Ubuntu*), or `srm -f filename` to have faster deletion and impose less work on the disk, or even `shred -n 1 -u` so that shred overwrites the file only once before deleting it (**coreutils** is the name of **the package** including shred in Debian derivatives).</div>

