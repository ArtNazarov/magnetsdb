What's new
===========================
- Search in several categories
- Stop words e.g search request "-Third;Quest" will find
"Thine First", "Second Thing" but not "Third Quest" or "Quest Third"
(available for requests by captions or labels)

How to build app from sources
===========================
Goto http://sourceforge.net/projects/lazarus/
Download files according to your arch, you should download
deb packages for Linux x64 from http://sourceforge.net/projects/lazarus/files/Lazarus%20Linux%20amd64%20DEB/Lazarus%201.4.4/

install all packages:
```
cd ~/Downloads
sudo dpkg -i fpc...
sudo dpkg -i fpc-src...
sudo dpkg -i lazarus...
sudo apt-get install -f
```

Launch Lazarus IDE
```
cd /usr/bin
./lazarus-ide
```

Add UniqueInstance from lpk (compile and install components to Lazarus IDE)

https://github.com/blikblum/luipack/tree/master/uniqueinstance

Open magnetsdb.lpi

Press Shift+F9 to build app or use menu item

App will be created into the folder with sources

About
=========================
This app is neither p2p download manager nor streaming player.
It's just compact CRUD wrapper.

Screenshots
==========================

Current version with English interface

- Adding

![screenshot](https://dl.dropbox.com/s/nib3h5pwgjfo4hh/gui_adding.png)

- Deleting

![screenshot](https://dl.dropbox.com/s/3xoy18x15ko2alc/gui_deleting.png)

- Editing

![screenshot](https://dl.dropbox.com/s/71n1zaiuww0mwxi/gui_editing1.png)

- Manage localization

![screenshot](https://dl.dropbox.com/s/amu0rc55ei8eg72/gui_localization.png)

- Changing settings

![screenshot](https://dl.dropbox.com/s/eu699dmcvwgegwg/gui_settings.png)

- GUI for calling importer tool

![screenshot](https://dl.dropbox.com/s/9e02ibw5aepa8hr/gui_importing.png)

- Search by category and caption

![screenshot](https://dl.dropbox.com/s/w7kmlrqedy7vnkk/under_linux9.png)

- Adding to bookmarks from multiselection

![screenshot](https://dl.dropbox.com/s/oghw8veudf9gtln/under_linux10.png)

![screenshot](https://dl.dropbox.com/s/4trdc0gfldc1bwx/under_linux8.png)

General view

![screenshot](https://dl.dropbox.com/s/zglac766rlb73q3/under_linux5.png)

![screenshot](https://dl.dropbox.com/s/hmr3jma0ooe1ctk/magnets_next_version.png)

- Process of import 
![screenshot](https://dl.dropbox.com/s/675f8rh3m8h4mgx/magnetsdb.png)
- Filtering 
![screenshot](https://dl.dropbox.com/s/vhozlfc30vk4px1/magnetsdb2.png)
- Night mode (linux) 
![screenshot](https://dl.dropbox.com/s/sno700lp96maxqi/under_linux.png)
- Customizing font size (linux) 
![screenshot](https://dl.dropbox.com/s/51xgilr4ni5nvz4/under_linux2.png)

Screenshots maybe not relevant because they'll updated after a few releases

Features
=======================
- Adding magnet link from clipboard
- Adding magnet link from by click in browser
- Import magnet links from csv file, binaries, plain text and dbf files
- Export lists to plain text and binaries
- Search and filter by caption, category or label
- History of requests, repeating previous request
- Sending magnetlink to custom handlers by hash
- Bookmarks, favs function
- UI: Save height, width of window and column sizes, customization of font size
- UI: Alternated colors in the grid,  second color scheme for nightmode
- Experimental: export lists to html pages (static website, 1.5.x)

Hotkeys
=======================
 F1 - help on the github
 F2 - goes to the first page
 F3 - viewer
 F4 - editor
 F5 - prev page
 F6 - next page
 F7 - handler 1
 F8 - delete record in fav or db
 F9 - add selected record to the bookmarks
 F10 - open browser and make search request
 F11 - enable selecting category and dropdown list
 Ins - add record to db
 Alt+Ins - importer gui
 
 Ctrl + mouse at db grid - select many records
 Shift + arrows, Shift+mouse at fav - select many records
 
Notes
=======================
Application used as download manager QBITTORRENT but by editing settings you can
easily set up other applications as tribler or peerflix magnet player - just view the instructions about
installing at http://www.webupd8.org/2014/03/peerflix-stream-torrents-with-vlc-or.html 
and change key app in settings to /usr/local/bin/Magnet-Video-Player.

From version >= 1.6 code for importing csv was extracted from
GUI viewer and saved as command line application.

Dialog of adding magnetlink will be showed if app 
called with one parameter(equals to magnetlink)

On double click at dbgrid or bookmarks  will be launched handler 1.

By default used &tr=http://retracker.local/announce parameter will be
added to link before sending it to handler but your can change it. Just
create file named tr.txt and put on each line required announcers.
You can find many different lists of announcers at the WWW,
for examples: http://bitmapcake.blogspot.ru/2015/05/list-of-working-torrent-trackers-2015-may.html,
https://www.reddit.com/r/opentrackerproject/comments/3pynqy/tracker_list_report_october_23_2015/ etc

Installation
======================
Just download magnetsdb, copy to desired location and make it executable e.g. chmod +x magnetsdb on Linux.
In selected directory will be created file settings.ini.

In section [general] you can change key 'app' which describe path to application using as browser/download manager for magnet links (as peerflix player by setting app=peerflix -v).

By default, in the Linux version it is equal to
app=/usr/bin/qbittorrent

Edit this line after installation if needed. 

Import of magnet links
==========================
Tool used very simple format CSV for importing lists of magnet links but import of large lists can take a long time.
Other way to get magnet links - paste it manually or copy file main.dbf, main.mdx.
For storing data used:
  version <=1.1.5.12  database DBF
  version >= 1.6 database Sqlite3

Related utilities 
=================
http://github.com/ArtNazarov/magnetsdb_importer_csv - command line tool

TODO
====================

- Detection win/linux for changing features on the flight
- Output export-import features from 1.5.x as command line tools 
- Test builds at other OS
- Remove dead code, disable tested functionality at the builds
- At db_funcs.pas incapsulate all procedures into wrapper ( db management class )

Requirements
=============
Sqlite3.dll (windows) or sqlite3.so (linux).
Can be dowloaded from official website https://www.sqlite.org/download.html

Localization
=============
Put en.ini file to app directory. By default, if ini file not present, will be loaded Russian precompiled interface.

To create other localization file:

1. Save en.ini with name like lang.ini to app directory
2. Rename to your native language values for controls (don't change keys
like favHandler1 etc)
3. To switch on your localization just
change key locale in settings.ini (locale=lang)
So, to using English that row must be written
as locale=en


Search
================

1. Request 'test' returns  'TeSt', 'GREATEST', 'The testing caption'
2. To found record were ALL labels looks like user input split labels using ' '.
For example, on request 'abc def' will be fetched records
like 'def abc', 'aBCx def', 'abc DEFZ'.
3. If category NOT selected search may be take a long time
4. When search engine in strict mode coincedence will be detected by
comparing only with beginning of the pattern e.g. with pattern 'test' will be found 
'TEST','tEst' but not 'greateST'. Strict mode useful for search on change,
but can reduce count of the results.


Categories
================
- To reduce categories at autocompletion list just edit categories.txt.
- To add new categories after import launch app with key 'reindex=YES' in settings.ini

How to create desktop icon at Linux
================
Install application at ~/magnetsdb

Create file magnetsdb.desktop at path 

/home/USERNAME/.local/share/applications

Paste to this file
```
[Desktop Entry]
Categories=Network
Comment[ru]=Manage magnet links
Comment=Manage magnet links
Exec=./magnetsdb/magnetsdb
GenericName[ru]=Database for magnet links
GenericName=Database for magnet links
Icon=/home/USERNAME/magnetsdb/magnet.png
Keywords=Network
MimeType=
Name[ru]=MagnetsDB
Name=MagnetsDB
Path=~/magnetsdb
StartupNotify=true
Terminal=true
TerminalOptions=
Type=Application
Version=1.1.x
X-DBUS-ServiceName=
X-DBUS-StartupType=
X-KDE-SubstituteUID=false
X-KDE-Username=
```
Don't forget to change USERNAME.

First launch as self test
=======================
During first launch will be created empty database and
setting up the indexes. After that into the category 'test' will be added some records. Also, the test base can be
created by calling self test of magnetsdb_importer_csv

```
cd ~/magnetsdb_importer_csv
./magnetsdb_importer_csv self_test=yes new_db=yes log=no
mv ~/main-sqlite.db ~/magnetsdb
```
Lists of OS where was launched successfully
=============================
- Linux Mint 17.2-17.1 32/64 bit (native), deb based
- openSUSE, rpm based, native
- Calculate Linux, source (gentoo) based, native
![screenshot](https://dl.dropbox.com/s/50apomn6gct3tlv/under_calculate_linux.png)
- MS Windows 7-8 32/64 bit (native)
- ReactOS

Win version was launched successfully under Wine 1.6.2

Windows notes
============================

After installation and first app launch
edit settings.ini, set keys browser and app
to correct path to browser and app for magnet links,
For example,
```
app=C:\Program Files\qBittorrent\qbittorrent.exe
browser=C:\Program Files\Mozilla Firefox\firefox.exe
```

Debian package for Linux x64
=======================================
https://mega.nz/#!l8liXApQ!yV3gVPeMHRZgx4K64Bn7J5l3_GjfXVG1Qy83J0hJZ0Y

This is dirty raw package, so app created and modify resource files INSIDE /usr/local/bin
such settings.ini etc. 

Package for rpm based distros like openSUSE
===================================
https://mega.nz/#!IxNyXIKS!p6rbqbyB0EGdr7civ4X3qihvfQYVqZow8WzTT0zOaN0


Notes about packages
============================

So, after installation you should launch base at 2 commands
```
cd /usr/bin
sudo magnetsdb
```
or copy base to ~ 
```
cd ~
cp /usr/local/bin/main-sqlite.db ~
./magnetsdb
```

After some fixes at next releases this behaviour will be changed


How to add magnetlinks from browser
==================================
For Firefox: goto settings, application,
at type magnet choose Other and select
magnetsdb.

Installer for Windows (within the base)
========================================

https://mega.nz/#!AtsjWSxQ!pOh80pmhu9EamI1BqTHHvQzQhDPsZJK2lB1vOpjft2w

Latest version (within the base, mirrors, zip)
================
https://mega.nz/#!ZpcUWaqZ!scUyi9bpWy53pTdncpLkbO1NQqT6wv2VCAYySN2fTr4


Updates of the base (mirrors)
===================
https://mega.nz/#!1893gJrC!GyXaIor5u6s3ysi9z17-Pur2BuTf3Xo8z2Hl_n1aSS8


THANKS TO DEVELOPERS
=====================
 
- QBITTORRENT (Christophe Dumez, ...)
- DELUGE (Andrew Resch, Damien Churchill, John Garland, Calum Lind, ...)
- ARIA2C (Tatsuhiro Tsujikawa, ...)
- PEERFLIX (mafintosh, ...)
- LUIPACK (Luiz Américo, ...)

 
DISCLAIMER
====================

- This program comes with no warranty. 
- You must use this program at your own risk.
- Do what you want with this code, it's not our problem
- Remember, there is a NOT a utility for exchanging or streaming files.
- The program comes with an empty database by default. 
- The demo base contains NOT verified and censored information obtained from Public sources on the Internet. The records for the demo base was provided by anonymous users. We are not responsible for their content.

![copyme](http://www.kopimi.com/kopimi/cccp.gif)
