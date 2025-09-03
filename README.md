# KillCountVanilla
Vanilla 1.12.1 addon for World of Warcraft that shows how many mobs you've killed in a tooltip

![](./screenshot.jpg)

## Installation
1. Download **[Latest Version](https://github.com/maloch11/KillCountVanilla/archive/refs/heads/main.zip)**
2. Unpack the Zip file
3. Rename the folder "KillCountVanilla-main" to "KillCountVanilla"
4. Copy "KillCountVanilla" into Wow-Directory\Interface\AddOns
5. Restart Wow

## Limitations
The combat log messages needed to verify a kill came from the player's party/raid are not sent for kills by raid members in a different group than the player so currently all deaths seen while inside an instance or part of a raid group are counted as kills by the player.

## Slash Commands
* **/kcount reset** Target a mob and reset it's kill count with this command
* **/kcount view &lt;mob name&gt;** View the kill count for the specified mob with this command
