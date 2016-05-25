unit magnets_constants;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  PageSize = 30;
  db_name = 'main-sqlite.db';
  search_engines_count = 5;
  hardcoded_se : array[0..search_engines_count-1] of String =
  (
   'https://isohunt.to/torrents/?ihq=',
   'https://btdigg.org/search?q=',
   'https://searx.me/?categories=images&q=',
   'https://duckduckgo.com/?ia=images&iax=1&q=',
   'http://torrent-finder.info/show.php?q='
  );



  ss : String = 'settings.ini';
  debug   : boolean = false;
  disable_features : boolean = true;
 {$IFDEF Windows}
  version : 0..1 = 1;
 {$ENDIF}
 {$IFDEF UNIX}
  version : 0..1 = 0;
 {$ENDIF}
  ixHandler0 : 0..3 = 0;
  ixHandler1 : 0..3 = 1;
  ixHandler2 : 0..3 = 2;
  ixHandler3 : 0..3 = 3;

  DefaultApps : array[0..1, 0..3] of String
  = (
     ('/usr/bin/qbittorrent', // Linux Version
      'peerflix -v',
      'aria2c',
      '/usr/bin/deluge'),
// TODO: change paths to Win versions
      ('C:\Program Files (x86)\qBittorrent\qbittorrent.exe',
      'C:\Program Files (x86)\qBittorrent\qbittorrent.exe',
      'C:\Program Files (x86)\qBittorrent\qbittorrent.exe',
      'C:\Program Files (x86)\qBittorrent\qbittorrent.exe')

      );

  strmaxsize = 100;

  magic = '4F059E20CDA1306BF48F1337F23C89FC452A7040';

implementation

end.

