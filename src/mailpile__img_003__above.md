<p class="fluo_green_frame">In the terminal window, you'll see that *Mailpile* also has a Command Line Interface (or just CLI).[^PythonShell]</p>

This is the command I've used to tell *Mailpile* **"please send *now* the emails which already are in the Outbox"**, when I was too impatient to wait during at most 90 seconds, which is the default interval for *Mailpile* to check if there are any emails in the Outbox:[^sendInterval90sec]  
`sendmail`\<enter\>

I can also access the Command Line Interface via the GUI, clicking the ***Settings and Tools*** gear icon in the upper right corner and then the ***<> CLI*** button. I prefer the terminal window, which gives me more lines visible at the same time. Both ways, however, I can scroll up to see previous output.

**This document includes [a section](#Mailpile_CLI) showing how to search and export emails or search and delete emails with the Command Line Interface.**

[^PythonShell] The above mentioned video [**Bjarni Einarsson: Mailpile**](https://www.youtube.com/watch?v=v_hCmxTH9ag), starting at 18 minutes, demonstrates that this console offers a tremendous power for advanced users, even a python shell if you enable it with the following steps:
    a. Settings (gear icon in the upper right corner) | Preferences | "Enable developer-only features" => On and click ***Save Settings***
    b. Settings again | Plugins, click on the new button you should now see, labeled **<> *Enable: hacks***
    c. Now you can access the python Command Line Interface, by typing this command in *Mailpile*'s CLI:  
      `hacks/pycli`<enter>
    
    Notice that the setting mentioned in the first step, Enable developer-only features, is in the ***Danger Zone***. That's because you can do a mess if you don't know what you're doing, or you do know but make a mistake.

    
[^sendInterval90sec] This command shows scheduled jobs:  
  `cron`\<enter\>  
  Here's the result I'm getting (notice the line starting by "sendmail"):
      
        Elapsed: 0.001s (cron: Displayed CRON schedule)
      
        Background CRON last ran at 2020-10-26 22:30.
        Current schedule:
      
         JOB                     INTERVAL LAST RUN         NEXT RUN         STATUS
         retrain_autotag            86400                  2020-10-27 05:03 new
         save_search_history          900 2020-10-26 22:26 2020-10-26 22:41 ok
         gpl_optimize                  30 2020-10-26 22:30 2020-10-26 22:30 ok
         rescan                       900 2020-10-26 22:24 2020-10-26 22:39 ok
         sendmail                      90 2020-10-26 22:29 2020-10-26 22:30 ok
         refresh_command_cache          5 2020-10-26 22:30 2020-10-26 22:30 ok
         save_metadata_index          900 2020-10-26 22:25 2020-10-26 22:40 ok
         tag_automation             28800                  2020-10-27 01:39 new
         motd                        3600 2020-10-26 22:29 2020-10-26 23:29 ok
  
  As far as I can tell, when you explicitly use the `sendmail` command in the CLI, you get `True` as the result when there are no new emails to send. <span class="fluo_orange_bgnd">**[needs clarification]**</span>  
  On the other hand, you may get some error messages if sendmail is already running.
