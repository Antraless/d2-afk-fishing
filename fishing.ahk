#singleinstance force
start = 0

if FileExist("e.png") {
	FileAppend, e.png found!`n, fishinglog.txt
}
else if (a_screenheight = 720) {
	UrlDownloadToFile, https://www.dropbox.com/s/3uhczcnsasqvhf4/720e.png?dl=1, e.png
	FileAppend, file e.png not found so downloadeded it at %a_screenheight%!`n, fishinglog.txt
}
else if (a_screenheight = 1080) {
	UrlDownloadToFile, https://www.dropbox.com/s/s7raqlhflem3mnr/1080e.png?dl=1, e.png
	FileAppend, file e.png not found so downloadeded it at %a_screenheight%!`n, fishinglog.txt
}
else if (a_screenheight = 1440) {
	UrlDownloadToFile, https://www.dropbox.com/s/p6hys484onl3zea/1440e.png?dl=1, e.png
	FileAppend, file e.png not found so downloadeded it at %a_screenheight%!`n, fishinglog.txt
}
else if (a_screenheight = 1600) {
	UrlDownloadToFile, https://www.dropbox.com/s/8vv34h9zmpyuoyy/1600e.png?dl=1, e.png
	FileAppend, file e.png not found so downloadeded it at %a_screenheight%!`n, fishinglog.txt
}
else if (a_screenheight = 2160) {
	UrlDownloadToFile, https://www.dropbox.com/s/piryg486wovy5dg/2160e.png?dl=1, e.png
	FileAppend, file e.png not found so downloadeded it at %a_screenheight%!`n, fishinglog.txt
}
else {
	MsgBox, Your resolution is currently unsupported.`n`nFor support join: https://discord.gg/jwVVmBRd
}


customcolor := "000000"
gui +lastfound +alwaysontop -caption +toolwindow
gui, color, %customcolor%
gui, font, s32, verdana
gui, add, text, vmytext cwhite, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX`nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
winset, transcolor, %customcolor% 255


settimer, updategui, 200
gosub, updategui
updategui:
if winactive("Destiny 2") {
    gui, show, x0 y0 noactivate 
    if (start = 0) {
        guicontrol,, mytext, F2 to close, F4 to start fishing`nFor support join: https://discord.gg/jwVVmBRd
    } 
    else {
        guicontrol,, mytext, F2 to close, F3 to pause fishing`nFish caught this run: %fish%
    }
}
else {
    gui, hide
}


F2:: ; press F2 to close the script
{
	send, {e up}
	FileAppend, Stopping script`n, fishinglog.txt
	exitapp 
}


F3:: ; press F3 to pause the script
{
	send, {e up}
	FileAppend, Reloading (pausing) script`n, fishinglog.txt
	reload
}


F4:: ; press F4 to start the script
{
	FileAppend, Script started`nAVersion: %a_ahkversion% SVersion:1.0.0`nWidth: %a_screenwidth%`nHeight: %a_screenheight%`n, fishinglog.txt
    fish = 0
    start = 1
    loop {
        loop {
            if !winactive("Destiny 2") {
				sleep 500 ; if this isn't here, multiple scripts open ??????? wtf????
				FileAppend, Destiny 2 is not active - pausing script`n, fishinglog.txt
                reload
            }
            else {
                imagesearch, Px, Py, a_screenwidth*0.35, a_screenheight*0.45, a_screenwidth*0.65, a_screenheight*0.8, *70, e.png
                if (errorlevel = 2) {
					MsgBox, imagesearch could not run, try running as administrator?
					FileAppend, Could not conduct the search!`n, fishinglog.txt
                }
                else if (errorlevel = 1) {
					fails++
					FileAppend, "E" could not be found on the screen! For support join: https://discord.gg/jwVVmBRd`n, fishinglog.txt
                }
				else {
                    fails = 0
					FileAppend, "E" found on screen!`n, fishinglog.txt
                    break
                }
                if (fails > 5000) {
                    setkeydelay, 250, 500
                    send wassddwwass 
					sleep 500 ; if this isn't here, multiple scripts open ??????? wtf????
					FileAppend, Fails threshhold reached!`n, fishinglog.txt
                    reload
                }
            }
        }
        send, {e down}
        sleep, 800
        send, {e up}
        if mod(num, 2) {
            fish++
			FileAppend, Caught a fish! (%fish% this run!)`n, fishinglog.txt
        }
        else {
			FileAppend, Sending movement inputs`n, fishinglog.txt
            send wasd
        }
        num++
    }
}
; with <3 from Antra