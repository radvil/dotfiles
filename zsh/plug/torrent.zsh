# This plugin creates a Torrent file based on a 
# [MagnetURI](https://en.wikipedia.org/wiki/Magnet_URI_scheme).
#
# usage:
# * `torrent-from_magnet <MagnetURI>`: creates Torrent file.

# Algorithm borrowed from http://wiki.rtorrent.org/MagnetUri and adapted to work with zsh.
# TODO: Test this function later!!
function torrent-from_magnet() {
	[[ "$1" =~ xt=urn:btih:([^\&/]+) ]] || return 1
	hashh=${match[1]}
	if [[ "$1" =~ dn=([^\&/]+) ]];then
	  filename=${match[1]}
	else
	  filename=$hashh
	fi
	echo "d10:magnet-uri${#1}:${1}e" > "$filename.torrent"
}
