<a name="IfYouEditTagNameThenEditKeywordToo"></a>

Look in the above picture at the search engine input field after clicking on the tag in the sidebar, in this case we read **"in:reddit"**.  

What we see after the ':' character is **the tag keyword** (**"all:mail"** is an exception to this format).

We don't see it when creating a tag, it's automatically added by *Mailpile* according to the tag name, but we _can_ see and modify it later by editing the tag settings, and actually **we want to keep it matched to the tag name** and change both accordingly, in case, so we don't get confused when searching in the CLI.

(We'll see later that we can use what we see in the search engine input field after clicking a tag to search with the [CLI](#Mailpile_CLI), e.g. `search in:inbox`\<enter\>. Then we can export emails, delete, tag or untag them...)
</div>


<a name="EditingTagsSettings"></a>

### Editing tags settings

We have seen [above](#OrganizingSidebar) how to modify the order of the elements in the sidebar.

<div class="lightblue_frame">**TIP:**

To edit the settings of a previously created tag:

- click the tag in the sidebar of the Graphical User Interface
- click the small gear icon or its label ***Edit***, above **on the left**, just below the search engine input field

**If you change the tag name**, you might want to <span class="fluo_green_bgnd">also modify the keyword accordingly</span>, you find it in the ***Technical Settings***.  
So you won't be confused by the results of your future search operations.

The keyword field is not visible at the moment of the tag creation, it's automatically created from the tag name.

<span class="fluo_orange_bgnd">**Not all characters** are valid for tag keywords, though **[needs clarification]**</span>, you'll realize by observing the keyword for the various tags you have created, at the right of "in:" in the search engine input field after you click each tag on the sidebar.
</div>

This document includes [a section](#Mailpile_CLI) showing how to search and export emails or search and delete emails with the Command Line Interface.
