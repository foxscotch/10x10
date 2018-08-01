# 10x10

This is a game based on the rad [1010! by Gram Games][1010]. The title is
probably not permanent, but we'll see how it goes.

It is dependent on LÖVE 11.1, and some external libraries, which are located in
the ext/ directory with their licenses. If they don't have version numbers, I'll
just specify the date that I downloaded the code.

 - [hump][hump] (0.4-2)
 - [knife][knife] (pulled on July 17, 2018)
 - [deep][deep] (2.0.3)

It also uses [MoonScript 0.5.0][moon] for most of the files. Specifically,
[conf.lua](./conf.lua) loads the MoonScript loader, and everything else just
imports the plain MoonScript files. For this to work, you do need to have the
MoonScript code or binaries somewhere on the import path. Personally, I just
stuck it in the LÖVE folder, but whatever works for you.


[1010]: http://gram.gs/game-detail-1010.html "1010!"
[hump]: https://github.com/vrld/hump "vrld/hump"
[knife]: https://github.com/airstruck/knife "airstruck/knife"
[deep]: https://github.com/Nikaoto/deep "Nikaoto/deep"
[moon]: https://github.com/leafo/moonscript "leafo/moonscript"
