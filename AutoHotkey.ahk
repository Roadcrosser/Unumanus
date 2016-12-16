/*
██╗   ██╗███╗   ██╗██╗   ██╗███╗   ███╗ █████╗ ███╗   ██╗██╗   ██╗███████╗
██║   ██║████╗  ██║██║   ██║████╗ ████║██╔══██╗████╗  ██║██║   ██║██╔════╝
██║   ██║██╔██╗ ██║██║   ██║██╔████╔██║███████║██╔██╗ ██║██║   ██║███████╗
██║   ██║██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║   ██║╚════██║
╚██████╔╝██║ ╚████║╚██████╔╝██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╔╝███████║
 ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
Unumanus v.2.2.2.2.2.2.2

Note: If you see a big garble of characters above, you might want to consider ignoring Step 2 and going to http://roadcrosser.xyz/Unumanus to get this file instead.
      While using this version is also fine, it'd just look worse.

 Install instructions:
 1. Download and install AutoHotkey from https://autohotkey.com/
 2. Copy this script into a text file with the name "AutoHotkey.ahk".
 3. Save the file in the Documents folder.
 4. Right-click the AutoHotkey Icon in the System Tray and select "Reload This Script".

*/
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance force
#Hotstring ?

;—————————————————————————————————————————————————————————————————————————————————————————————————
/*
╔═══════════════════════════╗
║ CONFIG FILES SURE ARE FUN ║
╚═══════════════════════════╝
*/

IniRead, Present, %A_MyDocuments%\UnumanusConfig.ini, Config, Does This Config File Exist

if Present != Probably
{
FileDelete, %A_MyDocuments%\UnumanusConfig.ini
FileAppend,
(
[Config]
Does This Config File Exist=Probably

[Don't Touch This.]
Definitely an important value=8

[Script Functions]
Enable Orange Randomizer=1
Enable Heats Randomizer=1
Enable Automatic Update Checking=1
How long to wait until checking for an update again (in milliseconds - 0 to disable)=21600000
Enable Surface Pen Remapping=0
Enable Volume Changing=1
FUN=2
), %A_MyDocuments%\UnumanusConfig.ini, UTF-8-RAW
}

IniRead, Important, %A_MyDocuments%\UnumanusConfig.ini, Don't Touch This., Definitely an important value

IniRead, OrgnRNG, %A_MyDocuments%\UnumanusConfig.ini, Script Functions, Enable Orange Randomizer
IniRead, HeatsRNG, %A_MyDocuments%\UnumanusConfig.ini, Script Functions, Enable Heats Randomizer
IniRead, AutoUpdate, %A_MyDocuments%\UnumanusConfig.ini, Script Functions, Enable Automatic Update Checking
IniRead, UpdateDelay, %A_MyDocuments%\UnumanusConfig.ini, Script Functions, How long to wait until checking for an update again (in milliseconds - 0 to disable)
IniRead, EnablePen, %A_MyDocuments%\UnumanusConfig.ini, Script Functions, Enable Surface Pen Remapping
IniRead, FUN, %A_MyDocuments%\UnumanusConfig.ini, Script Functions, FUN

if Important != 8
{
if FUN >= 1
{
MsgBox Look what you've done, you've changed the important value I told you not to touch!
MsgBox Hold on while I fix that...
}
IniWrite, 8, %A_MyDocuments%\UnumanusConfig.ini, Don't Touch This., Definitely an important value
}

if AutoUpdate = 1
{
Check_ForUpdate()
}

if FUN > 4
{
if FUN = 66
{
MsgBox Why would you set your fun value that high? It's not like Gaster's gonna come out or anything.
}
IniWrite, 4, %A_MyDocuments%\UnumanusConfig.ini, Script Functions, FUN
}

;—————————————————————————————————————————————————————————————————————————————————————————————————
/*
╔═══════════════════╗
║  RANDOMIZER INIT  ║
╚═══════════════════╝
*/

if HeatsRNG = 1
{
Heats1 = Wang Fire~|That guy whose name I cant remember~|That guy whose name I forgot~|Firey Whatsisface~|That guy who's made of fire, you know the one.~|Mr. Burns~|Steve~|Red Hot Chibi Pepper~|Mr. Hotpants McGee~|SO EASILY DEFEATED~|Grillby~|Mr. Explosion~|Burnie Cinders~|Jack Frost~|Potentia|Ignis|Heats|Flames|Firey|Hot|Fire|Hots|Fires|Flame|Flamey|Heaty|Burning|Char|Charred|Charry|Burns|Burn|Blazes|Blaze|Blazing|Ember|Embers|Arson|Sparky|Sparks|Infernal|Inferno|Melt|Melts|Melty|Melting|Seary|Searing|Sear|Swelter|Sweltering|Thermal|Warm|Roast|Roasty|Combustion|Combustiony|Broil|Broils|Broily|Broiling|Boil|Boils|Boily|Boiling|Warms|Flaming|Heating|Warming|Roasting|Flameo|Toast|Toasts|Toasting|Toasty|Lava|Lavas|Magma|Magmas|Stars|Star|Starry|Grill|Grilly|Grilling|Steam|Steamy|Steamer|Steams|Redhot|Redhots|Spicy|Spice|Spicing|Fuming|Fumes|Blast|Blasts|Blasting|Blaster|Cinder|Cinders|Pyro|Sizzling|Sizzle|Sizzler|Sizzles
Heats2 = man|guy|dude|face|head|waffle|bro|bud|bub|smith|runt|pip|ton|sir|ster|boy|ius|master|kid
StringSplit HeatsArray1, Heats1, |
StringSplit HeatsArray2, Heats2, |
Random, Randnum,1,% HeatsArray10 ; Heats
Heats1 := HeatsArray1%Randnum%
Random, Randnum,15,% HeatsArray10 ; Flames
Heats2 := HeatsArray1%Randnum%
Random, Randnum,1,% HeatsArray20 ; man
Heats3 := HeatsArray2%Randnum%
Heats4 := " " ; The letter space, the final frontier.
if Instr(Heats1, "~") > 0
{
  StringTrimRight, Heats1, Heats1, 1
  Heats2 =
  Heats3 =
  Heats4 =
}
}

if OrgnRNG = 1
{
Orng1 = Oranuelstaranda~|bogosort~|Bootleg Michaelangestar Jackson~|Stargarine~|nancy~|j{#}rew{!}3d9Sb~|Orange Quartz~|Roborangecop~|Star Orangefly~|Starangebucks~|Storangebucks~|Not Rodea~|Orangulus Rift~|John Jacob Orangeheimer Schmidt~|Georangeo Starmani~|orangudan~|orangutan~|orngasdlfjsdghj~|apple+|orbit+|Onigiri|Oran Jester|Oran-jee|dubmo|mango|Matt Groerange|oj|tangerine|oranot|norbert|oreana|oriana|orancle|ronage|blorenge|egnao|oringe|obinge|orbinge|orbin|oragn|orange|orgate|norgate|ogre|ogle|ronaeg|organ|oroongay|oingy boingy|egnaro|oarng|oingo boingo|orngear|ngroae|egroan|doorhinge|norgerge|ornge|ornage|orgne|organe|ograne|ongere|rangeo|oerange|oran berry|oregano|orenge|oregon|oregona|oranga|orgene|oronge|ereonge|rngeoa|rnoarg|orngea|rongea|ornga|oregangeo|organge|daniel-range|ordan|orgean|orgaen|orgn|red-yellow|yellow-red
Orng2 = juicestain|stem|spear|shed|nerd|clod|star|stare|stair|shtar|stra|strar|strer|sta|staro|stairs|star| star|starstar| starstar|ster|stror|stah|steh|sror|sar|score|sert|ASSERT|scrim|sploot|sweat|suit|stress|sort|spit|ASSET|swood|stan|juice|puff|-chan|-san|-kun|-sama|-sensei|stir|stick|starman|sink|shorgan
Orng3 = 1|10|11|12|13|14|15|16|17|18|19|one|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen
StringSplit Orngarray1, Orng1, |
StringSplit Orngarray2, Orng2, |
StringSplit Orngarray3, Orng3, |
Random, Randnum,1,% Orngarray10 ; orange
Orng1 := Orngarray1%Randnum%
Random, Randnum,1,% Orngarray20 ; star (opt)
Orng5 := Orngarray2%Randnum%
Random, Randnum,1,% Orngarray30 ; 12 (opt)
Orng6 := Orngarray3%Randnum%
Random, Randnum,1,% Orngarray30 ; 11 (opt)
Orng7 := Orngarray3%Randnum%
Random, Randnum, 1,5 ; chance to get suffix
if Randnum = 1
{
  Random, Randnum,1,% Orngarray20 ; star
  Orng2 := Orngarray2%Randnum%
}
else
{
  Orng2 =
}

Random, Randnum,1,3 ; chance to get a number
if Randnum = 1
{
  Random, Randnum, 1,% Orngarray40 ;12
  Orng3 := Orngarray3%Randnum%
}
else
{
  Orng3 =
}

Random, Randnum,1,3 ; chance to get a second number
if Randnum = 1
{
  Random, Randnum, 1,% Orngarray40 ;11
  Orng4 := Orngarray3%Randnum%
}
else
{
  Orng4 =
}

if Instr(Orng1, "~") > 0 ; Special Names that don't need no star
{
  StringTrimRight, Orng1, Orng1, 1
  Orng2 =
  Orng5 =
  Orng6 =
  Orng7 =
}

if Instr(Orng1, "+") > 0 ; Special Names that depend on the star for it's success
{
  StringTrimRight, Orng1, Orng1, 1
  Random, Randnum,1,% Orngarray20
  Orng2 := Orngarray2%Randnum%
}

if Orng2 =
{
  Orng3 =
}

if Orng3 =
{
  Orng4 =
}
}
;—————————————————————————————————————————————————————————————————————————————————————————————————
/*
╔══════════════╗
║ AUTO UPDATES ║
╚══════════════╝
*/

if AutoUpdate = 1
{
  if UpdateDelay != 0
  {
    if UpdateDelay is integer
    {
      Sleep %UpdateDelay%
      Reload
    }
  }
}
Return
;—————————————————————————————————————————————————————————————————————————————————————————————————
/*
╔═════════════════════╗
║ RANDOMIZER TRIGGERS ║
╚═════════════════════╝
*/

:*:<hf>::
if GetKeyState("CapsLock", "T") = 1
{
  StringUpper, Heats1, Heats1
  StringUpper, Heats2, Heats2
  StringUpper, Heats3, Heats3
}
Send %Heats1%%Heats4%%Heats2%%Heats3%
reload
return

:*:<oj>::
if GetKeyState("CapsLock", "T") = 1
{
  StringUpper, Orng1, Orng1
  StringUpper, Orng2, Orng2
  StringUpper, Orng4, Orng4
  StringUpper, Orng5, Orng5
}
Send %Orng1%%Orng2%%Orng3%%Orng4%
reload
return

:*:<oj2>::
if GetKeyState("CapsLock", "T") = 1
{
  StringUpper, Orng1, Orng1
  StringUpper, Orng5, Orng5
  StringUpper, Orng6, Orng6
  StringUpper, Orng7, Orng7
}
Send %Orng1%%Orng5%%Orng6%%Orng7%
reload
return

:*:<rip>::
if FUN >= 1
{
rip = https://www.youtube.com/watch?v=GJbjKX3MFnc|https://tcrf.net/images/8/80/Undertale_Mus_kingdescription.ogg|http://roadcrosser.xyz/`%7B`%7B`%7B`%7B`%7B`%7D`%7D`%7D`%7D`%7D/Studio`%20Pixel/Gameover.mp3|http://roadcrosser.xyz/`%7B`%7B`%7B`%7B`%7B`%7D`%7D`%7D`%7D`%7D/Danny`%20Baranowsky/Game`%20Over.mp3|http://roadcrosser.xyz/`%7B`%7B`%7B`%7B`%7B`%7D`%7D`%7D`%7D`%7D/Yann`%20van`%20der`%20Cruyssen/Game`%20Over.mp3|http://i.imgur.com/Iu436XX.png|http://i.imgur.com/Jy1n3v9.png|http://i.imgur.com/F34dyIW.png|http://i.imgur.com/31RzSh6.png|http://i.imgur.com/tPy9tHW.gif|http://i.imgur.com/nXmydCU.png|https://www.youtube.com/watch?v=RSrrniGr-ac|https://i.imgur.com/KxB69lc.gif|http://roadcrosser.xyz/clap.mp3|http://i.imgur.com/y3rMXjr.png|https://www.youtube.com/watch?v=4vSNnVVBdIg|http://i.imgur.com/7FpLZE0.png|https://www.youtube.com/watch?v=t1-5KxXz8zw|011100100110100101110000|726970|http://i.imgur.com/600QcFT.png|http://i.imgur.com/sq6neSB.png|http://i.imgur.com/ZKFN1Hj.png|rip|.-. .. .--.

StringSplit riparray, rip, |
Random, Randnum, 1, % riparray0
rip := riparray%Randnum%
Send %rip%
}
return

;—————————————————————————————————————————————————————————————————————————————————————————————————

/*
╔══════════════════╗
║  SUSPEND/RELOAD  ║
╚══════════════════╝
*/
^!a::Suspend

;^r::Reload

:*:<reload>::
Reload
return

;—————————————————————————————————————————————————————————————————————————————————————————————————
/*
╔══════════════════╗
║SURFACE PEN REMAPS║
╚══════════════════╝
*/
;Click top once
#F20::
if EnablePen = 1
{
Send, {RWin up}
Send, ^z
}
Return

;Click top twice
#F19::
if EnablePen = 1
{
Send, {RWin up}
Send, {MButton}
}
Return

;Hold top
#F18::
if EnablePen = 1
{
Send, {RWin up}
Send,^+4
}
Return
;—————————————————————————————————————————————————————————————————————————————————————————————————
/*
╔══════════════════╗
║ TEXT REPLACEMENT ║
╚══════════════════╝
*/

;Texty stuff for text
:?0:adn::and
::@@::@gmail.com


:*:<binary>::
if FUN >= 1
{
SendRaw 01101000011101000111010001110000001110100010111100101111011100100110111101100001011001000110001101110010011011110111001101110011011001010111001000101110011110000111100101111010001011110111010001101001011011010110010100101111
}
return

:*:<hex>::
if FUN >= 1
{
SendRaw 68 74 74 70 3a 2f 2f 72 6f 61 64 63 72 6f 73 73 65 72 2e 78 79 7a 2f 74 69 6d 65 2f
}
return

:*:<bee>::
if FUN >= 1
{
SendRaw Accordion to all known laws of aviation, there is no way that a bee should be able to fly. Its wings are too small to get its fat little body off the ground. The bee, of course, flies anyways. Because bees don't care what humans think is impossible.
}
return

:*:<letthebasskick>::
if FUN >= 1
{
SendRaw O-oooooooooo AAAAE-A-A-I-A-U-JO-oooooooooooo AAE-O-A-A-U-U-A-E-eee-ee-eee AAAAE-A-E-I-E-A-JO-ooo-oo-oo-oo EEEEO-A-AAA-AAAA O-oooooooooo AAAAE-A-A-I-A-U-JO-oooooooooooo AAE-O-A-A-U-U-A-E-eee-ee-eee AAAAE-A-E-I-E-A-JO-ooo-oo-oo-oo EEEEO-A-AAA-AAAA
}
return

:*:<script>::http://roadcrosser.xyz/Unumanus/
:*:<changelog>::http://roadcrosser.xyz/Unumanus/changelog/
:*:<troubleshoot>::http://roadcrosser.xyz/Unumanus/broke/

:?0b0:wow::
if FUN >= 3
{
Random, Randnum, 1, 100
  if Randnum = 1
  {
    MsgBox Ethan, Great moves. Keep it up. I'm proud of you.
  }
}
return

:*?0b0:kkk:: ; ĶҞҠ
if FUN >= 3
{
  SendEvent {Backspace}{Backspace}{Backspace}{U+0136}{U+049E}{U+04A0}
}
return

;Kaomoji

:*:<shrug>:: ; ¯\_(ツ)_/¯
{
SendEvent {U+0xAF}{\}{_}{(}{U+30C4}{)}{_}{/}{U+0xAF}
}
return

:*:<shrug2>:: ; ┐(￣ ヘ ￣;)┌
{
SendEvent {U+2510}({U+FFE3} {U+30D8} {U+FFE3};){U+250C}
}
return

:*:<lod>:: ; ಠ_ಠ
{
SendEvent {U+0CA0}{_}{U+0CA0}
}
return


:*:<flip>:: ; (╯°□°)╯︵┻━┻
{
SendEvent {(}{U+256F}{U+00B0}{U+25A1}{U+00B0}{)}{U+256F}{U+FE35}{U+253B}{U+2501}{U+253B}
}
return

:*:<unflip>:: ; ┬─┬ノ(ಠ_ಠノ)
{
SendEvent {U+252C}{U+2500}{U+252C}{U+30CE}{(}}{U+0CA0}{_}{U+0CA0}}{U+30CE}{)}
}
return

:*:<grr>:: ; (ノಠ益ಠ)ノ
{
SendEvent {(}{U+30CE}{U+0CA0}{U+76CA}{U+0CA0}{)}{U+30CE}
}
return

:*:<rightpointface>:: ; (☞ﾟヮﾟ)☞
{
SendEvent {(}{U+261E}{U+FF9F}{U+30EE}{U+FF9F}{)}{U+261E}
}
return

:*:<leftpointface>:: ; ☜(ﾟヮﾟ☜)
{
SendEvent {U+261C}{(}{U+FF9F}{U+30EE}{U+FF9F}{U+261C}{)}
}
return

:*:<magic>:: ; (ﾉ◕ヮ◕)ﾉ*:・ﾟ✧
{
SendEvent {(}{U+FF89}{U+25D5}{U+30EE}{U+25D5}{)}{U+FF89}{*}{:}{U+30FB}{U+FF9F}{U+2727}
}
return

:*:<frisk>:: ; (—_—)
{
SendEvent {(}{U+2014}{_}{U+2014}{)}
}
return

:*:<wut>:: ; ఠ͟ ಠ
{
SendEvent {U+0C20}{U+035F}{U+0CA0}{Left}{Space}{Right}
}
return

:*:<facepalm>:: ; (－‸ლ)
{
SendEvent {(}{U+FF0D}{U+2038}{U+10DA}{)}
}
return

:*:<squid>:: ; くコ:彡
{
SendEvent {U+304F}{U+30B3}:{U+5F61}
}
return

;—————————————————————————————————————————————————————————————————————————————————————————————————
;Special characters I'll probably never use

:*:<^1>:: ; ¹
{
SendEvent {U+00B9}
}
return

:*:<^2>:: ; ²
{
SendEvent {U+00B2}
}
return

:*:<^3>:: ; ³
{
SendEvent {U+00B3}
}
return

:*:<?!>:: ; ‽
{
SendEvent {U+203D}
}
return

:*:<!?>:: ; ‽
{
SendEvent {U+203D}
}
return

:*:<cloud>:: ; ☁
{
SendEvent {U+2601}
}
return

:*:<sun>:: ; ☼
{
SendEvent {U+263C}
}
return

:*:<umbrella>:: ; ☂
{
SendEvent {U+2602}
}
return

:*:<cent>:: ; ¢
{
SendEvent {U+00A2}
}
return

:*:<euro>:: ; €
{
SendEvent {U+20AC}
}
return

:*:<pound>:: ; £
{
SendEvent {U+00A3}
}
return

:*:<yen>:: ; ¥
{
SendEvent {U+00A5}
}
return

:*:<note>:: ; ♪
{
SendEvent {U+266A}
}
return

:*:<note2>:: ; ♫
{
SendEvent {U+266B}
}
return

:*:<radioactive>:: ; ☢
{
SendEvent {U+2622}
}
return

::->:: ; →
{
SendEvent {U+2192}
}
return

::<-:: ; ←
{
SendEvent {U+2190}
}
return

::<v>:: ; ↓
{
SendEvent {U+2193}
}
return

::^^:: ; ↑
{
SendEvent {U+2191}
}
return

:*:<black>:: ; █
{
SendEvent {U+2588}
}
return

:*:(C):: ; ©
{
SendEvent {U+00A9}
}
return

:*:(R):: ; ®
{
SendEvent {U+00AE}
}
return

:*:(TM):: ; ™
{
SendEvent {U+2122}
}
return

:*:<.>:: ; ●
{
SendEvent {U+25CF}
}
return

:*:<deg>:: ; °
{
SendEvent {U+00B0}
}
return

:*:<sqrt>:: ; √
{
SendEvent {U+221A}
}
return

:*:<box>:: ; ☐
{
SendEvent {U+2610}
}
return

:*:<heart>:: ; ♥
{
SendEvent {U+2665}
}
return

:*:<pilcrow>:: ; ¶
{
SendEvent {U+00B6}
}
return

:*:<gear>:: ; ⚙
{
SendEvent {U+2699}
}
return

:*:=/=:: ; ≠
{
SendEvent {U+2260}
}
return

:*:<oo>:: ; ∞
{
SendEvent {U+221E}
}
return

:*:<em>:: ; —
{
SendEvent {U+2014}
}
return

:*:<zw>:: ; ​
{
SendEvent {U+200B}
}
return

^+Space:: ; ​
{
SendEvent {U+200B}
}
return

:*:<wj>:: ; ⁠
{
SendEvent {U+2060}
}
return

:*:<rtl>:: ; ‮
{
SendEvent {U+202E}
}
return

:*:<feff>:: ; ﻿
{
SendEvent {U+FEFF}
}
return

:*:<1/4>:: ; ¼
{
SendEvent {U+00BC}
}
return

:*:<1/2>:: ; ½
{
SendEvent {U+00BD}
}
return

:*:<3/4>:: ; ¾
{
SendEvent {U+00BE}
}
return

:*:<1/3>:: ; ⅓
{
SendEvent {U+2153}
}
return

:*:<2/3>:: ; ⅔
{
SendEvent {U+2154}
}
return

:*:<1/5>:: ; ⅕
{
SendEvent {U+2155}
}
return

:*:<2/5>:: ; ⅖
{
SendEvent {U+2156}
}
return

:*:<3/5>:: ; ⅗
{
SendEvent {U+2157}
}
return

:*:<4/5>:: ; ⅘
{
SendEvent {U+2158}
}
return

:*:<1/6>:: ; ⅙
{
SendEvent {U+2159}
}
return

:*:<5/6>:: ; ⅚
{
SendEvent {U+215A}
}
return

:*:<1/8>:: ; ⅛
{
SendEvent {U+215B}
}
return

:*:<3/8>:: ; ⅜
{
SendEvent {U+215C}
}
return

:*:<5/8>:: ; ⅝
{
SendEvent {U+215D}
}
return

:*:<7/8>:: ; ⅞
{
SendEvent {U+215E}
}
return


;—————————————————————————————————————————————————————————————————————————————————————————————————
;Greek Letters (or some of them, anyway.)

:*:<a>:: ; α
{
SendEvent {U+03B1}
}
return

:*:<b>:: ; β
{
SendEvent {U+03B2}
}
return

:*:<D>:: ; Δ
{
SendEvent {U+0394}
}
return

:*:<T>:: ; Θ
{
SendEvent {U+0398}
}
return

:*:<t>:: ; Θ
{
SendEvent {U+03B8}
}
return

:*:<u>:: ; μ
{
SendEvent {U+03BC}
}
return

:*:<pi>:: ; π
{
SendEvent {U+03C0}
}
return

:*:<E>:: ; Σ
{
SendEvent {U+03A3}
}
return

:*:<O>:: ; Ω
{
SendEvent {U+03A9}
}
return

;—————————————————————————————————————————————————————————————————————————————————————————————————
/*
╔══════════════════╗
║  VOLUME CHANGER  ║
╚══════════════════╝
*/

!z:: SoundSet, 0 ; 0%

~z & x::
	if GetKeyState("Alt") {
        SoundSet, 15 ; 15%
        return
    }
  return

~x & z::
	if GetKeyState("Alt") {
        SoundSet, 15 ; 15%
        return
    }
  return

!x:: SoundSet, 30 ; 30%

~x & c::
	if GetKeyState("Alt") {
        SoundSet, 50 ; 50%
        return
    }
  return

~c & x::
	if GetKeyState("Alt") {
        SoundSet, 50 ; 50%
        return
    }
  return

!c:: SoundSet, 60 ; 60%

!v:: SoundSet, 100 ; 100%

;—————————————————————————————————————————————————————————————————————————————————————————————————
/*
╔══════════════════╗
║    CUP HOLDER    ║
╚══════════════════╝
*/
; It will be extremely hilarious if this works.
; DISCLAIMER: Do NOT put your cups in the CD drive.

:*:<cup holder>::
if FUN >= 2
{
Drive, Eject
}
return

;—————————————————————————————————————————————————————————————————————————————————————————————————
/*
╔══════════════════╗
║  SCRIPT UPDATER  ║
╚══════════════════╝
*/
; Update script by Rsending91 https://autohotkey.com/board/topic/72559-func-self-script-updater/

:*:<update>::
Reload
return

Check_ForUpdate(_ReplaceCurrentScript = 1, _SuppressMsgBox = 0, _CallbackFunction = "", ByRef _Information = "")
{

	Static Script_Name := "Unumanus"
	, Version_Number := "2.2.2.2.2.2.2"
	, Update_URL := "http://roadcrosser.xyz/Unumanus/Version.ini"
	, Retry_Count := 3

	Random,Filler,10000000,99999999
	Version_File := A_Temp . "\" . Filler . ".ini"
	, Temp_FileName := A_Temp . "\" . Filler . ".tmp"
	, VBS_FileName := A_Temp . "\" . Filler . ".vbs"

	Loop,% Retry_Count
	{
		_Information := ""

		UrlDownloadToFile,%Update_URL%,%Version_File%

		IniRead,Version,%Version_File%,Info,Version,N/A

		If (Version = "N/A"){
			FileDelete,%Version_File%

			If (A_Index = Retry_Count)
				_Information .= "The version info file doesn't have a ""Version"" key in the ""Info"" section or the file can't be downloaded."
			Else
				Sleep,500

			Continue
		}

		If (Version "" != Version_Number){
			If (_SuppressMsgBox != 1 and _SuppressMsgBox != 3){
				MsgBox,0x4,Unumanus Update!,Hey look, I updated %Script_Name%!`nChangelog: http://roadcrosser.xyz/Unumanus/changelog`nCurrent version: %Version_Number%`nNew version: %Version%`n`nYou should, like, download it now.

				IfMsgBox,Yes
					MsgBox_Result := 1
			}

			If (_SuppressMsgBox or MsgBox_Result){
				IniRead,URL,%Version_File%,Info,URL,N/A

				If (URL = "N/A")
					_Information .= "The version info file doesn't have a valid URL key."
				Else {
					SplitPath,URL,,,Extension

					If (Extension = "ahk" And A_AHKPath = "")
						_Information .= "The new version of the script is an .ahk filetype and you do not have AutoHotKey installed on this computer.`r`nReplacing the current script is not supported."
					Else If (Extension != "exe" And Extension != "ahk")
						_Information .= "The new file to download is not an .EXE or an .AHK file type. Replacing the current script is not supported."
					Else {
						IniRead,MD5,%Version_File%,Info,MD5,N/A

						Loop,% Retry_Count
						{
							UrlDownloadToFile,%URL%,%Temp_FileName%

							IfExist,%Temp_FileName%
							{
								If (MD5 = "N/A"){
									_Information .= "The version info file doesn't have a valid MD5 key."
									, Success := True
									Break
								} Else {
									Ptr := A_PtrSize ? "Ptr" : "UInt"
									, H := DllCall("CreateFile",Ptr,&Temp_FileName,"UInt",0x80000000,"UInt",3,"UInt",0,"UInt",3,"UInt",0,"UInt",0)
									, DllCall("GetFileSizeEx",Ptr,H,"Int64*",FileSize)
									, FileSize := FileSize = -1 ? 0 : FileSize

									If (FileSize != 0){
										VarSetCapacity(Data,FileSize,0)
										, DllCall("ReadFile",Ptr,H,Ptr,&Data,"UInt",FileSize,"UInt",0,"UInt",0)
										, DllCall("CloseHandle",Ptr,H)
										, VarSetCapacity(MD5_CTX,104,0)
										, DllCall("advapi32\MD5Init",Ptr,&MD5_CTX)
										, DllCall("advapi32\MD5Update",Ptr,&MD5_CTX,Ptr,&Data,"UInt",FileSize)
										, DllCall("advapi32\MD5Final",Ptr,&MD5_CTX)

										FileMD5 := ""
										Loop % StrLen(Hex:="123456789ABCDEF0")
											N := NumGet(MD5_CTX,87+A_Index,"Char"), FileMD5 .= SubStr(Hex,N>>4,1) . SubStr(Hex,N&15,1)

										VarSetCapacity(Data,FileSize,0)
										, VarSetCapacity(Data,0)

										If (FileMD5 != MD5){
											FileDelete,%Temp_FileName%

											If (A_Index = Retry_Count)
												_Information .= "The MD5 hash of the downloaded file does not match the MD5 hash in the version info file."
											Else
												Sleep,500

											Continue
										} Else
											Success := True
									} Else {
										DllCall("CloseHandle",Ptr,H)
										Success := True
									}
								}
							} Else {
								If (A_Index = Retry_Count)
									_Information .= "Unable to download the latest version of the file from " . URL . "."
								Else
									Sleep,500
								Continue
							}
						}
					}
				}
			}
		} Else
			_Information .= "No update was found."

		FileDelete,%Version_File%
		Break
	}

	If (_ReplaceCurrentScript And Success){
		SplitPath,URL,,,Extension
		Process,Exist
		MyPID := ErrorLevel

		VBS_P1 =
		(LTrim Join`r`n
			On Error Resume Next
			Set objShell = CreateObject("WScript.Shell")
			objShell.Run "TaskKill /F /PID %MyPID%", 0, 1
			Set objFSO = CreateObject("Scripting.FileSystemObject")
		)

		If (A_IsCompiled){
			SplitPath,A_ScriptFullPath,,Dir,,Name
			VBS_P2 =
			(LTrim Join`r`n
				Finished = False
				Count = 0
				Do Until (Finished = True Or Count = 5)
					Err.Clear
					objFSO.CopyFile "%Temp_FileName%", "%Dir%\%Name%.%Extension%", True
					If (Err.Number = 0) then
						Finished = True
						objShell.Run """%Dir%\%Name%.%Extension%"""
					Else
						WScript.Sleep(1000)
						Count = Count + 1
					End If
				Loop
				objFSO.DeleteFile "%Temp_FileName%", True
			)

			Return_Val :=  Temp_FileName
		} Else {
			If (Extension = "ahk"){
				FileMove,%Temp_FileName%,%A_ScriptFullPath%,1
				If (Errorlevel)
					_Information .= "Error (" . Errorlevel . ") unable to replace current script with the latest version."
				Else {
					VBS_P2 =
					(LTrim Join`r`n
						objShell.Run """%A_ScriptFullPath%"""
					)

					Return_Val :=  A_ScriptFullPath
				}
			} Else If (Extension = "exe"){
				SplitPath,A_ScriptFullPath,,FDirectory,,FName
				FileMove,%Temp_FileName%,%FDirectory%\%FName%.exe,1
				FileDelete,%A_ScriptFullPath%

				VBS_P2 =
				(LTrim Join`r`n
					objShell.Run """%FDirectory%\%FName%.exe"""
				)

				Return_Val :=  FDirectory . "\" . FName . ".exe"
			} Else {
				FileDelete,%Temp_FileName%
				_Information .= "The downloaded file is not an .EXE or an .AHK file type. Replacing the current script is not supported."
			}
		}

		VBS_P3 =
		(LTrim Join`r`n
			objFSO.DeleteFile "%VBS_FileName%", True
		)

		If (_SuppressMsgBox < 2)
		{
			If (InStr(VBS_P2, "Do Until (Finished = True Or Count = 5)"))
			{
				VBS_P3 .= "`r`nIf (Finished = False) Then"
				VBS_P3 .= "`r`nWScript.Echo ""Update failed."""
				VBS_P3 .= "`r`nElse"
				If (Extension != "exe")
					VBS_P3 .= "`r`nobjFSO.DeleteFile """ A_ScriptFullPath """"
				VBS_P3 .= "`r`nWScript.Echo ""Update completed successfully."""
				VBS_P3 .= "`r`nEnd If"
			} Else
				VBS_P3 .= "`r`nWScript.Echo ""Update complected successfully."""
		}

		FileDelete,%VBS_FileName%
		FileAppend,%VBS_P1%`r`n%VBS_P2%`r`n%VBS_P3%,%VBS_FileName%

		If (_CallbackFunction != ""){
			If (IsFunc(_CallbackFunction))
				%_CallbackFunction%()
			Else
				_Information .= "The callback function is not a valid function name."
		}

		RunWait,%VBS_FileName%,%A_Temp%,VBS_PID
		Sleep,2000

		Process,Close,%VBS_PID%
		_Information := "Error (?) unable to replace current script with the latest version.`r`nPlease make sure your computer supports running .vbs scripts and that the script isn't running in a pipe."
	}

	_Information := _Information = "" ? "None" : _Information

	Return Return_Val
}
