export EDITOR='vim'
export VISUAL='vim'
export BROWSER='firefox'
export HISTTIMEFORMAT="%F %T "			# Add a timestamp to history

shopt -s checkwinsize				# update windows size on command
shopt -s cdspell                                # this will correct minor spelling errors in a cd 
shopt -s cmdhist                                # save multi-line commands in history as single line

#################################################
# Video Reencoding                              #
#################################################

function vrecode() {
    hres=800
    crf=33
    
    case "$1" in
        none|no)
              ffmpeg -i ${2} -vf "scale=$hres:-1" -threads 0 -crf $crf -vcodec libx264 ${2}.mp4 
              ;;
        cw|right)
              ffmpeg -i ${2} -vf "scale=$hres:-1, transpose=1" -threads 0 -crf $crf -vcodec libx264 ${2}.mp4 
              ;;
        ccw|left)
              ffmpeg -i ${2} -vf "scale=$hres:-1, transpose=2" -threads 0 -crf $crf -vcodec libx264 ${2}.mp4 
              ;;
        flip)
              ffmpeg -i ${2} -vf "scale=$hres:-1, transpose=1, transpose=1" -threads 0 -crf $crf -vcodec libx264 ${2}.mp4 
              ;;
        *)
            echo "Usage: vrecode <cw|ccw|flip> input.vid"    
      esac
}



##################################################
# Archives                                       #
##################################################

# Extracting
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# Creating archives 
function mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
function mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
function mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }



##################################################
# Utilities                                      #
##################################################

# Makes directory then moves into it
function mkcdr {
    mkdir -p -v $1
    cd $1
}

# Get external IP
function myip {
  myip=`elinks -dump http://checkip.dyndns.org:8245/`
  echo "${myip}"
}


# This will give you an apt-history command with install, upgrade, remove and rollback options. 
# Use it like apt-get: apt-history install
function apt-history(){
      case "$1" in
        install)
              cat /var/log/dpkg.log | grep 'install '
              ;;
        upgrade|remove)
              cat /var/log/dpkg.log | grep $1
              ;;
        rollback)
              cat /var/log/dpkg.log | grep upgrade | \
                  grep "$2" -A10000000 | \
                  grep "$3" -B10000000 | \
                  awk '{print $4"="$5}'
              ;;
        *)
              cat /var/log/dpkg.log
              ;;
      esac
}

##################################################
# Ascii to all                                   #
##################################################
function asc2all() {
        if [[ $1 ]]; then
                echo "ascii $1 = binary $(asc2bin $1)"
                echo "ascii $1 = octal $(asc2oct $1)"
                echo "ascii $1 = decimal $(asc2dec $1)"
                echo "ascii $1 = hexadecimal $(asc2hex $1)"
                echo "ascii $1 = base32 $(asc2b32 $1)"
                echo "ascii $1 = base64 $(asc2b64 $1)"
        fi
}
# Helper functions
function asc2bin() { [ $1 ] && echo "obase=2 ; $(asc2dec $1)" | bc; }
function asc2b64() { [ $1 ] && echo "obase=64 ; $(asc2dec $1)" | bc;} 
function asc2b32() { [ $1 ] && echo "obase=32 ; $(asc2dec $1)" | bc;} 
function asc2dec() { [ $1 ] && printf '%d\n' "'$1'"; }  
function asc2hex() { [ $1 ] && echo "obase=16 ; $(asc2dec $1)" | bc; } 
function asc2oct() { [ $1 ] && echo "obase=8 ; $(asc2dec $1)" | bc; }


##################################################
# Temperature Conversion                         #
##################################################
function cel2fah() { [ $1 ] && echo "scale=2; $1 * 1.8  + 32" | bc; }
function cel2kel() { [ $1 ] && echo "scale=2; $1 + 237.15" | bc; }
function fah2cel() { [ $1 ] && echo "scale=2 ; ( $1 - 32  ) / 1.8" | bc; }
function fah2kel() { [ $1 ] && echo "scale=2; ( $1 + 459.67 ) / 1.8 " | bc; }
function kel2cel() { [ $1 ] && echo "scale=2; $1 - 273.15" | bc; }
function kel2fah() { [ $1 ] && echo "scale=2; $1 * 1.8 - 459,67" | bc; }

##################################################
# Decimal <-> Hex                                #
##################################################
function dec()          { printf "%d\n" $1; }
function hex()          { printf "0x%08x\n" $1; }

#####################################################
# Execute a given Linux command on a group of files #
# Example: batchexec sh ls                          # 
# Example: batchexec sh chmod 755                   #
#####################################################
function batchexec()
{
    find . -type f -iname '*.'${1}'' -exec ${@:2}  {} \; ;
}

##################################################
# Bookmarking                                    #
##################################################
 
###### bookmarking the current directory in 'alias' form
function bookmark() {
        # copyright 2007 - 2010 Christopher Bratusek
        if [[ $1 != "" && $(alias | grep -w go-$1) == "" ]]; then
                echo "alias go-$1='cd $PWD'" >> $HOME/.bookmarks
                . $HOME/.bookmarks
        elif [[ $1 == "" ]]; then
                echo "need name for the bookmark."
        else    echo "bookmark go-$1 already exists."
        fi
}
function unmark() {
        # copyright 2007 - 2010 Christopher Bratusek
        if [[ $(alias | grep -w go-$1= ) != "" ]]; then
                sed -e "/go-$1/d" -i $HOME/.bookmarks
                xunalias go-$1
        fi
}
# cto file1.jpg file2.jpg file3.jpg pics
function cto() {
    eval lastarg=\${$#}
    targetdir=`getBookmark $lastarg`
    echo "Copying files to $targetdir"
    if [ -n "$targetdir" ]; then
        for dir in "$@";
            do
                if [ "$dir" != $lastarg ]; then
                    cp -iv "$dir" "$targetdir"
                fi
            done
    fi
}
 
# mto vid1.avi vid2.avi videos
function mto() {
    eval lastarg=\${$#}
    targetdir=`getBookmark $lastarg`
    echo "Moving files to $targetdir"
    if [ -n "$targetdir" ]; then
        for dir in "$@";
            do
                if [ "$dir" != $lastarg ]; then
                    mv -iv "$dir" "$targetdir"
                fi
            done
    fi
}
function getBookmark() {
    case "$1" in
    video|vids|vid) echo "~/Videos" ;; # video, vids and vid are shortcuts to use with the functions below, the bookmarked directory is "~/videos"
    images|img|pics|pictures) echo "~/Pictures";;
    *) echo "" ;;
    esac
}


##################################################
# Checksum                                       #
# Example:                                       #
#   Create hash: checksum -g sha1 <files>        #
#   Check hash : checksum -c <hash_file>
##################################################
 
function checksum()
# copyright 2007 - 2010 Christopher Bratusek
{
        action=$1
        shift
        if [[ ( $action == "-c" || $action == "--check" ) && $1 == *.* ]]; then
                type="${1/*./}"
        else    type=$1
                shift
        fi
        case $type in
                md5 )
                        checktool=md5sum
                ;;
                sha1 | sha )
                        checktool=sha1sum
                ;;
                sha224 )
                        checktool=sha224sum
                ;;
                sha256 )
                        checktool=sha256sum
                ;;
                sha384 )
                        checktool=sha384sum
                ;;
                sha512 )
                        checktool=sha512sum
                ;;
        esac
        case $action in
                -g | --generate )
                        for file in "${@}"; do
                                $checktool "${file}" > "${file}".$type
                        done
                ;;
                -c | --check )
                        for file in "${@}"; do
                                if [[ "${file}" == *.$type ]]; then
                                        $checktool --check "${file}"
                                else    $checktool --check "${file}".$type
                                fi
                        done
                ;;
                -h | --help )
                ;;
        esac
}

######################################################
# Record Screencast on full resolution and save to $1#
# Defaults to no audio and x264 video                #
######################################################
function screencastx264() 
{
	ffmpeg -f x11grab -s ` xdpyinfo | grep 'dimensions:'|awk '{print $2}'` -an -vcodec libx264 -vpre lossless_ultrafast -r 25 -i :0.0 -sameq ${1}.mp4
}
function screencast() 
{
	ffmpeg -f x11grab -s ` xdpyinfo | grep 'dimensions:'|awk '{print $2}'` -an -r 25 -i :0.0 -sameq ${1}.mp4
}
#######################################################################
# Share current working directory on port 8000, Ctrl-C to quit server #
#######################################################################
function webtemp() 
{
	python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"
}

##################################################
# Lookup a word with dict.org                    #
##################################################
 
###### define "whatever"
function dic() { curl dict://dict.org/d:"$@" ; }

###### look in Webster
function webster() { curl dict://dict.org/d:${1}:web1913; }

###### generates a unique and secure password with SALT for every website that you login to
### TODO: Does not seem right
function sitepass2()
{
salt="this_salt";pass=`echo -n "$@"`;for i in {1..500};do pass=`echo -n $pass$salt|sha512sum`;done;echo$pass|gzip -|strings -n 1|tr -d "[:space:]"|tr -s '[:print:]' |tr '!-~' 'P-~!-O'|rev|cut -b 2-15;history -d $(($HISTCMD-1));
}


##################################################
# Rip a file with handbrake and good options     #
##################################################
 
function rip() {
handbrake -i /dev/dvd -o ${HOME}/Movies/${1}.mp4 -L -U -F -f mp4 -e x264 -b 4000 -B 192
}

##################################################
# Screencasting with mplayer webcam window       #
##################################################
 
function screencastw()
{
mplayer -cache 128 -tv driver=v4l2:width=176:height=177 -vo xv tv:// -noborder -geometry "95%:93%" -ontop | ffmpeg -y -f alsa -ac 2 -i pulse -f x11grab -r 30 -s `xdpyinfo | grep 'dimensions:'|awk '{print $2}'` -i :0.0 -acodec pcm_s16le output.wav -an -vcodec libx264 -vpre lossless_ultrafast -threads 0 output.mp4
}

##################################################
# Shot - takes a screenshot of your current      #
# window                                         #
##################################################
 
function shot()
{
import -frame -strip -quality 75 "$HOME/$(date +%s).png"
}

#################################################
# Search for a show at TV.COM                    #
##################################################
 
function tvcom() {
firefox "http://www.tv.com/search.php?type=11&stype=all&tag=search%3Bfrontdoor&qs="${@}"&stype=program" &
}

##################################################
# Run a command, redirecting output to a file,   #
# then edit the file with vim                    #
##################################################
 
function vimcmd() { $1 > $2 && vim $2; }

