**NOTICE:** I have restored my *previous* *Mailpile* setup.[^restoringPreviousMailpileGnupgFolders] And a few more days have passed.

[^restoringPreviousMailpileGnupgFolders] Here is how I restored my previous ~/.local/share/Mailpile folder and my previous ~/.gnupg folder.  
    
    ````
    mv -i ~/.local/share/Mailpile ~/.local/share/Mailpile_createdOnlyForTheTutorialWillDeleteSoon  
    mv -i ~/.local/share/Mailpile_renamedToRestartFromScratchForTheTutorial ~/.local/share/Mailpile  
    mv -i ~/.gnupg ~/.gnupg_onlyForTheTutorialWillDeleteSoon  
    mv -i ~/.gnupg_b4_tutorial ~/.gnupg
    ````
    
    **You don't need to do this now**, I'm just detailing this possibility of easily switching to/from another entire Mailpile setup (without having to switch to another user on your computer) because it might be useful to you.


<a name="tagsAsAttributes"></a>

## Tags as attributes

We have already been [using tags](#UsingTags).  
As [promised at the end of that section](#willRetakeTagsLater), here are attributes.

<div class="fluo_green_frame">**A tag-attribute enables us to establish that multiple emails belonging to different categories have something in common, and to search for those emails at once**.
</div>



One of *Mailpile*'s icons is **a star icon**.  
I could use it for an ***Important*** tag-attribute if I wanted to keep this aspect as in *Thunderbird*.  
Then, clicking this tag in the sidebar, I'd see all the emails I've tagged as important, possibly belonging to various tags-categories.

- I have created an ***Important*** tag-attribute
- I have created an ***Interesting*** tag-attribute

I'm going to click the latter in the sidebar.

<a name="InterestingB4subtags"></a>
