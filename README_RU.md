Как собрать приложение из исходников
===========================
Перейдите на http://sourceforge.net/projects/lazarus/
Загрузите в соответствии с вашей архитектурой установочные файлы.
Для Linux x64 их можно забрать отсюда
http://sourceforge.net/projects/lazarus/files/Lazarus%20Linux%20amd64%20DEB/Lazarus%201.4.4/

Установите в следующем порядке пакеты:
```
cd ~/Downloads
sudo dpkg -i fpc...
sudo dpkg -i fpc-src...
sudo dpkg -i lazarus...
sudo apt-get install -f
```

Запустите интегрированную среду разработки Lazarus
```
cd /usr/bin
./lazarus-ide
```

Установите UniqueInstance из lpk (компилировать, установить)

https://github.com/blikblum/luipack/tree/master/uniqueinstance

Откройте файл magnetsdb.lpi из каталога с исходниками

Нажмите Shift+F9, чтобы собрать приложение или воспользуйтесь пунктом меню

Файл с исполнимым машинным кодом будет размещен компилятором в каталоге с исходниками

Необходимые оптимизации можно настроить в Параметрах проекта.

О приложении
=========================
Данный программный продукт не является пиринговым загрузчиком или
потоковым проигрывателем. Это просто компактная оболочка-клиент для
создания, редактирования, обновления и удаления записей в базе данных.


Скриншоты
==========================

Текущая версия

- Поиск по категории и названию

![screenshot](https://dl.dropbox.com/s/w7kmlrqedy7vnkk/under_linux9.png)



- Перенос в избранное (множественное выделение)

![screenshot](https://dl.dropbox.com/s/oghw8veudf9gtln/under_linux10.png)

![screenshot](https://dl.dropbox.com/s/4trdc0gfldc1bwx/under_linux8.png)

- Общий вид

![screenshot](https://dl.dropbox.com/s/zglac766rlb73q3/under_linux5.png)
![screenshot](https://dl.dropbox.com/s/hmr3jma0ooe1ctk/magnets_next_version.png)

- Импорт 
![screenshot](https://dl.dropbox.com/s/675f8rh3m8h4mgx/magnetsdb.png)
- Выборка 
![screenshot](https://dl.dropbox.com/s/vhozlfc30vk4px1/magnetsdb2.png)
- Альтернативная схема (linux) 
![screenshot](https://dl.dropbox.com/s/sno700lp96maxqi/under_linux.png)
- Размер шрифта (linux) 
![screenshot](https://dl.dropbox.com/s/51xgilr4ni5nvz4/under_linux2.png)

Скриншоты могут быть нерелевантны, поскольку обновляются от сборки к сборке

Функции
=======================
- Добавление магнет-ссылки из буфера обмена
- Добавление ссылки из браузера
- Импорт магнет ссылок из csv, txt, dbf, bin
- Экспорт в bin, txt
- Поиск по заголовку, метке и категории
- История поиска, повтор предыдущего запроса
- Вызов программы-обработчика магнет-ссылок
- Избранное (добавление, удаление, отправка в обработчик)
- Интерфейс: сохранение высоты и ширины экрана, ширины колонок, размера текста
- Интерфейс: чередование цветов в таблице, альтернативная цветовая схема под ночной режим
- Тестирование: экспорт список в html страницы (статический сайт, 1.5.x)

Горячие клавиши
=======================
 F1 - справка
 F2 - переход на 1 страницу 
 F3 - карточка
 F4 - редактор
 F5 - пред. страница
 F6 - след. страница
 F7 - обработчик 1
 F8 - удалить из избранного или базы
 F9 - добавить в избранное
 F10 - открыть браузер и выполнить поиск
 F11 - включить категорию и открыть список
 Ins - добавить 1 запись в базу
 Alt+Ins - окно импортера
 
 Ctrl + мышь в таблице - выбрать несколько записей
 Shift + стрелки, Shift+мышь в избранном - выбрать несколько записей


Примечания
=======================
В качестве менеджера загрузок ожидается QBITTORRENT но отредактировав настройки 
вы можете назначить другое приложение вроде tribler или peerflix -  руководство по настройке
доступно на http://www.webupd8.org/2014/03/peerflix-stream-torrents-with-vlc-or.html ,
затем измените ключ app на /usr/local/bin/Magnet-Video-Player или peerflix -v

Начиная с версии >= 1.6 код импорта csv из GUI перенесен в отдельное приложение
командной строки.

Будет показан диалог добавления ссылки если в качестве параметра запуска будет
указана ссылка.

Будет запущен обработчик 1 при двойном щелчке по избранному или таблице.

По умолчанию к ссылке будет добавлен параметр &tr=http://retracker.local/announce перед тем, как она будет передана в программу-обработчик. Чтобы изменить это,
просто создайте в каталоге с программой файл с именем tr.txt и
построчно перечислите в этом файле необходимые трекеры. Вы можете найти эти списки в Сети, н-р 
http://bitmapcake.blogspot.ru/2015/05/list-of-working-torrent-trackers-2015-may.html,
https://www.reddit.com/r/opentrackerproject/comments/3pynqy/tracker_list_report_october_23_2015/ и др.

Установка
======================
Достаточно загрузить magnetsdb, скопировать в подходящий каталог и сделать его исполнимым.
Для Linux выполните chmod +x magnetsdb. Убедитесь, что у программы есть права на чтение и запись
в данный каталог. В каталоге программой будет создан файл с настройками settings.ini.

В секции [general] можно поменять ключ 'app' который соответствует полном пути к выбранному проигрывателю или
менеджеру загрузок 

В GNU\Linux версии ключ имеет значение
app=/usr/bin/qbittorrent

При необходимости отредактируйте эту строку


Относящиеся к программе утилиты
=================
http://github.com/ArtNazarov/magnetsdb_importer_csv - утилита-импортер для командной строки (терминала)

Зависимости
=============
Вам понадобятся файлы Sqlite3.dll (windows) или sqlite3.so (linux).
Вы можете получить их на официальном сайте https://www.sqlite.org/download.html

Локализация
=============
Чтобы перевести приложение на другой язык, скопируйте под новым именем файл en.ini
в каталог приложения, например, пусть это будет lang.ini
Переведите интерфейс, не трогая ключи, т.е. не изменяйте favHandler1 и т.п.
Локализованная надпись должна быть записана после знака =.

Чтобы переключить приложение на  подготовленную Вами локализацию,
в файле settings.ini поменяйте значение locale на название файла
локализации (без ini). В случае с примером на английском языке
это будет locale=en.ini, в случае с Вашей локализацией locale=lang.ini.

Если файл локализации найден не будет, приложение загрузится с русскоязычным
интерфейсом.

Поиск
========================
1. Запрос 'test' вернет как 'tEsT' так и 'greatest', 'THE TESTING CAPTION'
2. Разделив метки символом пробела можно найти записи,
содержащие ВСЕ метки. Запрос 'abc def' выберет
записи с метками "abcx DEf", "dEF abC", "defz abc" и т.п.
3. Если категория не выбрана, поиск может быть медленным.
4. В строгом режиме осуществляется только сравнение
с началом образца, т.е. по запросу 'test' будет
найдено 'TEST' и 'testing', но не 'greaTeSt'.
Естественно, включение этого режима ускорит поиск,
но может сократить число результатов в выдаче

Категории
=========================
1. Уменьшить число категорий в автодополнении можно отредактировав файл categories.txt
(в импортер будет добавлена функция фильтрации)
2. После импорта новых данных список категорий можно обновить, изменив перед запуском
в файле setting.ini ключ reindex (reindex=YES)

Ярлык для запуска (Linux)
========================
Создайте файл magnetsdb.desktop в каталоге
/home/USERNAME/.local/share/applications

с содержимым

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
Не забудьте заменить USERNAME.

Первый запуск
=======================
При первом запуске будет создана пустая база,
в которой в категорию test будет добавлено
несколько записей. Также создать
тестовую базу можно с помощью вызова
```
cd ~/magnetsdb_importer_csv
./magnetsdb_importer_csv self_test=yes new_db=yes log=no
mv ~/main-sqlite.db ~/magnetsdb
```

Как добавлять ссылки из браузера
=========================
Для Firefox: Настройки->Приложения,
выбираем magnet, действие -> Использовать другое...,
выбираем magnetsdb

Список операционных систем
============================
- MS Windows 7/8, 32/64 бит
- Linux Mint 17.2/17.1, 32/64 бит 
- openSUSE 
- Calculate Linux 
![screenshot](https://dl.dropbox.com/s/50apomn6gct3tlv/under_calculate_linux.png)
- ReactOS

Win-версия также успешно запускалась с помощью Wine 1.6.2

По Windows-версии
============================

После установки и первого запуска самостоятельно отредактируйте settings.ini в каталоге программы,  изменив ключи browser и app
так, чтобы они указывали на полный путь к браузеру и приложению, понимающему  передачу магнет-ссылок в качестве параметра.

Для примера,
```
app=C:\Program Files\qBittorrent\qbittorrent.exe
browser=C:\Program Files\Mozilla Firefox\firefox.exe
```

Установочный deb-пакет
=======================
https://mega.nz/#!l8liXApQ!yV3gVPeMHRZgx4K64Bn7J5l3_GjfXVG1Qy83J0hJZ0Y


Установочный пакет для rpm-based дистрибутивов, таких как openSUSE
========================
https://mega.nz/#!IxNyXIKS!p6rbqbyB0EGdr7civ4X3qihvfQYVqZow8WzTT0zOaN0


Замечания по установке из пакетов
=========================

Из-за привязки ресурсов к текущему каталогу запуск временно по
```
cd /usr/local/bin
sudo magnetsdb
```
либо копируете базу в домашнюю папку
```
cd ~
cp /usr/local/bin/main-sqlite.db ~
./magnetsdb
```

Установщик Windows (с базой, zip)
=========================
https://mega.nz/#!AtsjWSxQ!pOh80pmhu9EamI1BqTHHvQzQhDPsZJK2lB1vOpjft2w

Версия (с базой, zip)
=================
https://mega.nz/#!ZpcUWaqZ!scUyi9bpWy53pTdncpLkbO1NQqT6wv2VCAYySN2fTr4


Обновленная база
===================
https://mega.nz/#!1893gJrC!GyXaIor5u6s3ysi9z17-Pur2BuTf3Xo8z2Hl_n1aSS8


БЛАГОДАРНОСТИ 
=============
 
- QBITTORRENT (Christophe Dumez, ...)
- DELUGE (Andrew Resch, Damien Churchill, John Garland, Calum Lind, ...)
- ARIA2C (Tatsuhiro Tsujikawa, ...)
- PEERFLIX (mafintosh, ...)
- LUIPACK (Luiz Américo, ...)

ОТКАЗ ОТ ОТВЕТСТВЕННОСТИ
========================

- Эта программа  поставляется как есть без каких-либо гарантий
- Вы должны использовать эту программу на свой страх и риск
- Делайте что хотите с этим кодом, это не наша проблема
- Программа не является утилитой для стриминга (вещания) или обмена файлами
- По умолчанию программа предоставляется с пустой тестовой базой
- Демонстрационая база содержит НЕ проверенную и цензурированную информацию полученную из открытых источников сети Интернет. Записи, внесенные в базу данных, были предоставлены анонимными пользователями. Мы не несем
ответственности за их содержание.

![copyme](http://www.kopimi.com/kopimi/cccp.gif)