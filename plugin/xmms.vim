function XMMS (action, message, song)
	if a:action == "pause"
		call system("xmmsctrl " . a:action)
		sleep (1)
		call XMMSTitle ("XMMS: " . substitute(system("if xmmsctrl paused; then echo \"currently paused\"; else echo \"currently playing\";fi"), "\n", "", "") . ": ", 0)
	elseif a:action == "louder"
		call XMMSVolume ("+")
	elseif a:action == "quieter"
		call XMMSVolume ("-")
	else
		call system("xmmsctrl " . a:action)
		if v:shell_error
			echo "XMMS: action failed: " . a:action
		else
			if a:song
				call XMMSTitle (a:message, 1)
			else
				echo a:message
			endif
		endif
	endif
endfunction

function XMMSTitle (message, wait)
	sleep (a:wait)
	echo a:message . substitute(system("xmmsctrl title"), "\n", "", "")
endfunction

function XMMSVolume (action)
	call system("xmmsctrl vol " . a:action . "5")
	sleep (1)
	echo "XMMS: currently playing at " . substitute(system("xmmsctrl getvol"), "\n", "", "") . "%"
endfunction

map <silent> <F6> :call XMMS("quieter", "", 0)<CR>
map <silent> <F7> :call XMMS("louder", "", 0)<CR>
map <silent> <F8> :call XMMS("title", "XMMS: currently playing: ", 1)<CR>
map <silent> <F9> :call XMMS("launch", "XMMS: launched", 0)<CR>
map <silent> <S-F9> :call XMMS("quit", "XMMS: closed", 0)<CR>
map <silent> <F10> :call XMMS("play", "XMMS: currently playing: ", 1)<CR>
map <silent> <S-F10> :call XMMS("stop", "XMMS: stopped playing: ", 1)<CR>
map <silent> <F11> :call XMMS("pause", "", 0)<CR>
map <silent> <S-F11> :call XMMS("shuffle", "", 0)<CR>
map <silent> <F12> :call XMMS("next", "XMMS: currently playing: ", 1)<CR>
map <silent> <S-F12> :call XMMS("previous", "XMMS: currently playing: ", 1)<CR>
