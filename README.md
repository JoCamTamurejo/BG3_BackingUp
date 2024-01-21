### Set up your multiplayer multiplattform (Windows/MAC) campaign!

Author: jose.camacho

Have you read about the issues of unsync versions of Baldur's Gate 3 in MAC and Windows? Did you know that it causes not being able to continue to campaing? Do you want a set up to be able to continue it even if updates come?  
  
Well, I am going to give you a solution, although it may be not for everyone because you would need some "advanced" Windows know-how.  
  
Writing this guide was a suggestion by the steam user (citation needed!), thanks for your support!  
  
Here we go.

Legal Notice:
(c) 2024, Jose Camacho jose.camacho@jocam.net
Released under the MIT License https://opensource.org/licenses/MIT

# Table of contents
1. [Problem description](#problem-descriptionproblem-description)
2. [Prerequisites and assumptions for the proposal to work](#prerequisites-and-assumptions-for-the-proposal-to-work)
3. [What this guide proposes you](#what-this-guide-proposes-you)
4. [Fooling Steam](#fooling-steam)
5. [Before we start](#before-we-start)
6. [Step by Step for Windows advanced users](#step-by-step-for-windows-advanced-users)
7. [A new PC Patch comes, not yet for Mac](#a-new-pc-patch-comes-not-yet-for-mac)
8. [Finally, Mac Patch is there!](#finally-mac-patch-is-there)
9. [Using windows BATCH Scripts](#using-windows-batch-scripts)
10. [When to use the scripts](#when-to-use-the-scripts)
11. [Scripts content](#scripts-content)

# Problem description
Baldur's Gate 3 (BG3) is a great game with an amazing feature: multiplayer across different plattforms. That is a really technical challenge due to the deep in the system differences between, for example, Mac and Windows.  
  
To get that working, Larian had to take different decissions, being one of them, only allow Multiplayer across plattforms when all players have **exactly** the same version of the game installed  
  
If you have a look into the BG3 version number, it is something like 4.1.1.123456. Given a player in Windows has that version 4.1.1.123456, the player can only play with Mac users that have exactly that version, 4.1.1.123456  
  
If the Mac player has version 4.1.1.123400 installed, they cannot join the same multiplayer session.  
  
Given the complexity of the development of such a game like BG3, it is aditionally difficult to have the development cycle in all plattforms exactly parallel, and as a result, versions in Mac and Windows do not come synchronized.  
  
Meaning, when a patches is published, it is going to be a time between its publishing for Windows and for Mac.

# Prerequisites and assumptions for the proposal to work
The only needed prerequisite is that the curren BG3 version of the people to join your Multiplayer is the same; that is, you could join all the Multiplayer session.  
  
As assumption, Windows version is published previously to the Mac version

# What this guide proposes you
In software, there is a functionality called "symlinks". According to Wikipedia, "is a file whose purpose is to point to a file or directory (called the "target") " ([Wikipedia](https://steamcommunity.com/linkfilter/?u=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSymbolic_link)\).  
  
Let's say that you have a windows folder (=directory) called _Download_. You can create a symlink called _gotoDownload_ pointing to _Download_.  
  
If you open the folder _gotoDownload_ in explorer, it shows you the content of _Download_, yes, we fool Windows Explorer: it thinks is in a folder called _gotoDownload_, but in fact, it is in _Download_!  
  
How they work for our purpose? BG3  
contains all its needed information in two folders: _bin_ and _Data_. Basically, we are going to:  

* Copy the current version that is working as _bin_noUpdate_ and _Data_noUpdate_  
    
* Rename the current _bin_ as _bin_original_ and current _Data_ as _Data_original_  
    
* Create a symlink named _bin_ targeting to _bin_noUpdate_  
    
* Create a symlink named _Data_ targeting to _Data_noUpdate_

  
So when Steam wants to open BG3 by calling the content of bin, it is fooled, opening the content of the folder _bin_noUpdate_

# Fooling Steam
In the previous section you see that current _bin_ is renamed as _bin_original_. Why we do that?  
  
When a new patch comes, Steam checks the version of BG3 and compares with the version of the patch installed. Steam maintains that information internally. So when Steam decides, it needs to update BG3, we delete the current _bin_ and _Data_ symlinks and create new ones to _bin_original_ and _Data_original_.  
  
So what is going to update Steam? Exactly, the _bin_original_ and _Data_original_ folders, leaving _bin_noUpdate_ and _Data_noUpdate_ as they name suggest: no updated  
  
After Steam applies the patch, it updates the internal information about the game Version, and tells you, "everything ok, you can play it". In this point, we delete the symlinks again creating them to targeting back to _bin_noUpdate_ and _Data_noUpdate_.  
  
And when you start the game, it starts the "no Update" version, the one compatible with your Mac pals.

# Before we start
Disable the BG3 automatic update, select the "Update at start" option!

# Step by Step for Windows advanced users
1. In windows Explorer, open the folder where the game is saved. Where is it? Go to your Steam library, select BG3 and in the properties symbol (the "wheel"), inside "Manage" you find "Browse local files"  
2. Copy the _bin_ and _Data_ folder in the same folder, rename the copys as _bin_noUpdate_ and _Data_noUpdate_  
3. Rename the _bin_ folder as _bin_original_ and Data as _Data_original_  
4. Create the no Update symlinks. To do that:  
4.1. Open a Windows CMD Terminal as **administrator** (press Windows key and type cmd, select "Open it as administrator"  
4.2. Using the command "cd", change into the directory where game is saved (shown in the Windows Explorer bar)  
4.3. Create symlinks for _bin_ and _Data_ pointing your noUpdate folders. Commands are:  
```
mklink /D bin bin-noUpdate  
mklink /D Data Data-noUpdate  
```

# A new PC Patch comes, not yet for Mac
If a new version is available (rememberto disable the automatic updates at Steam start):  
1. Close Steam, do not update the game  
2. Now, we are going to create symlinks to the original game after deleting the current symlink using these commands (do not close the CMD after that). Open the CMD as in the previous version and change to BG3 folder.  
It is **VERY** important to use _rmdir_ instead of delete files!:  
```
rmdir /Q bin  
rmdir /Q Data  
mklink /D bin bin_original  
mklink /D Data Data_original  
```
3. Now, you can open again Steam and update the game. It updates the "original" folder and the internal Steam database  
4. Change back the symlinks to the no Update folders using the Windows CMD  
```
rmdir /Q bin  
rmdir /Q Data  
mklink /D bin bin_noUpdate  
mklink /D Data Data_noUpdate  
```

# Finally, Mac Patch is there
In this case, your no Update version is problably different than the current Mac Version. But most likely, the current Windows version is already there, so we are going to update the "no Update" copies of BG3 in Windows  
  
Normally, after the Mac patch is available, Larian publishes a new Windows patch to make both versions compatible.  
  
So the steps to do are mostly similar to the described in the previous section, but now, update the "no Update" folders:  
1 Create symlinks to the original game after deleting the current symlink using these commands (do not close the CMD after that). Open the CMD as in the previous section and change to BG3 folder.  
Remember that is **VERY** important to use _rmdir_ instead of delete files!:  
```
rmdir /Q bin  
rmdir /Q Data  
mklink /D bin bin_original  
mklink /D Data Data_original  
```
2. Now, you can open again Steam and update the game. It updates the "original" folder and the internal Steam database  
3. IMPORTANT: Test the multiplayer works!  
4. Delete the no Update folders and copy the original as no Update, renaming then after the copy is done  
5. Change back the symlinks to the no Update folders using the Windows CMD  
```
rmdir /Q bin  
rmdir /Q Data  
mklink /D bin bin_noUpdate  
mklink /D Data Data_noUpdate
```

# Using windows BATCH Scripts
Maybe you prefer to use windows batch scripts for all this. I created 3 different scripts to automatize the work:  

* **_saveme.bat**: This is the initial script, to be executed everytime we need to update the "no Update" copy  
    
* **_noUpdateLink.bat**: Deletes current symlinks and creates them to target the no Update folders  
    
* **_officalLinks.bat**: Deletes current symlinks and creates them to target the original _bin_ and _Data_ folders

  
To use them, copy the batch files in the BG3 folder. I suggest you to create a Desktop shortcut to that folder to make things easier  
  
**And remember to execute them as administrator! (right click - "Execute as administrator" - confirm it)**

# When to use the scripts
A new patch version comes in Windows, not yet in Mac?  
1. Use _officialLink.bat  
2. Open Steam and update BG3  
3. Use _noUpdateLink.bat  
  
  
A new patch version comes in Windows, and ALSO in Mac?  
1. Use _officialLink.bat  
2. Open Steam and update BG3  
3. Test with your friends, Multiplayer works (!)  
4. Use _saveme.bat  
5. Use _noUpdateLink.bat

# Scripts content
Check the Github repository to get the updated (and probably bug-cleaner) version of the scripts
