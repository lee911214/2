## List of qBittorrent Version that is supported
declare -a qb_ver_list=("5.1.3" "4.1.9.1" "4.2.5" "4.3.9" "4.4.5" "4.5.5" "4.6.7" "5.0.3" "5.1.0beta1" )
#Generate the list of qBittorrent Version that is supported
unset qb_name_list i
for i in "${qb_ver_list[@]}"
do
	qb_name_list+=("qBittorrent-$i")
done
## List of libtorrent Version that is supported
declare -a lib_ver_list=("1_1_14" "v1.2.20" "v2.0.11")
#Generate the list of libtorrent Version that is supported
unset lib_name_list i
for i in "${lib_ver_list[@]}"
do
	lib_name_list+=("libtorrent-$i")
done
qb_ver_choose(){
	need_input "Please choose your qBittorrent Version:"
	select opt in "${qb_name_list[@]}"
	do
		case $opt in
		qBittorrent*)
			qb_ver=${opt}; break
			;;
		*) warn "Please choose a valid version" ;;
		esac
	done
}

lib_ver_choose(){
	## Check if qb_ver is empty
	if [[ -z "$qb_ver" ]]; then
		qb_ver_choose
	fi

	## Allow users to determine which version of libtorrent to go with the qBittorrent
	need_input "Please choose your libtorrent version:"
	select opt in "${lib_name_list[@]}"
	do
		case $opt in
		libtorrent*)
			lib_ver=${opt}; break
			;;
		*) warn "Please choose a valid version" ;;
		esac
	done
}

lib_ver_check(){
	## Check if lib_ver is empty
	if [[ -z "$lib_ver" ]]; then
		lib_ver_choose
	fi
	## Check if the libtorrent version is supported
	if [[ ! " ${lib_name_list[@]} " =~ " ${lib_ver} " ]]; then
		warn "libtorrent $lib_ver is not supported"
		lib_ver_choose
	fi
	## Check if the libtorrent version is compatible with qBittorrent version
	if [[ "${qb_ver}" =~ "4.1." ]]; then
		while true
		do
			if [[ ! "${lib_ver}" == "libtorrent-1_1_14" ]]; then
				tput sgr0; clear
				warn "qBittorrent $qb_ver is not compatible with libtorrent $lib_ver"
				warn "qBittorrent $qb_ver is compatible with libtorrent-1_1_x only"
				warn "Please choose a compatible version"
				lib_ver_choose
			else
				break
			fi
		done
	elif [[ "${qb_ver}" =~ "4.2." ]]; then
		while true
		do
			if [[ ! "${lib_ver}" =~ "libtorrent-v1.2." ]]; then
				tput sgr0; clear
				warn "qBittorrent $qb_ver is not compatible with libtorrent $lib_ver"
				warn "qBittorrent $qb_ver is compatible with libtorrent-v1.2.x only"
				warn "Please choose a compatible version"
				lib_ver_choose
			else
				break
			fi
	done
	elif [[ "${qb_ver}" =~ "4.3." ]]; then
		while true
		do
			if [[ ! "${lib_ver}" =~ "libtorrent-v1.2." ]]; then
				tput sgr0; clear
				warn "qBittorrent $qb_ver is not compatible with libtorrent $lib_ver"
				warn "qBittorrent $qb_ver is compatible with libtorrent-v1.2.x only"
				warn "Please choose a compatible version"
				lib_ver_choose
			else
				break
			fi
	done
	elif [[ "${qb_ver}" =~ "4.4." ]]; then
		while true
		do
			if [[ ! "${lib_ver}" =~ "libtorrent-v1.2." ]] && [[ ! "${lib_ver}" =~ "libtorrent-v2.0." ]]; then
				tput sgr0; clear
				warn "qBittorrent $qb_ver is not compatible with libtorrent $lib_ver";
				warn "qBittorrent $qb_ver is compatible with libtorrent-v1.2.x or libtorrent-v2.0.x only";
				warn "Please choose a compatible version";
				lib_ver_choose
			else
				break
			fi
		done
	elif [[ "${qb_ver}" =~ "4.5." ]]; then
		while true
		do
			if [[ ! "${lib_ver}" =~ "libtorrent-v1.2." ]] && [[ ! "${lib_ver}" =~ "libtorrent-v2.0." ]]; then
				tput sgr0; clear
				warn "qBittorrent $qb_ver is not compatible with libtorrent $lib_ver"
				warn "qBittorrent $qb_ver is compatible with libtorrent-v1.2.x or libtorrent-v2.0.x only"
				warn "Please choose a compatible version"
				lib_ver_choose
			else
				break
			fi
		done
	elif [[ "${qb_ver}" =~ "4.6." ]]; then
		while true
		do
			if [[ ! "${lib_ver}" =~ "libtorrent-v1.2." ]] && [[ ! "${lib_ver}" =~ "libtorrent-v2.0." ]]; then
				tput sgr0; clear
				warn "qBittorrent $qb_ver is not compatible with libtorrent $lib_ver"
				warn "qBittorrent $qb_ver is compatible with libtorrent-v1.2.x or libtorrent-v2.0.x only"
				warn "Please choose a compatible version"
				lib_ver_choose
			else
				break
			fi
		done
	elif [[ "${qb_ver}" =~ "5.0." ]]; then
		while true
		do
			if [[ ! "${lib_ver}" =~ "libtorrent-v1.2." ]] && [[ ! "${lib_ver}" =~ "libtorrent-v2.0." ]]; then
				tput sgr0; clear
				warn "qBittorrent $qb_ver is not compatible with libtorrent $lib_ver"
				warn "qBittorrent $qb_ver is compatible with libtorrent-v1.2.x or libtorrent-v2.0.x only"
				warn "Please choose a compatible version"
				lib_ver_choose
			else
				break
			fi
		done
	elif [[ "${qb_ver}" =~ "5.1." ]]; then
		while true
		do
			if [[ ! "${lib_ver}" =~ "libtorrent-v1.2." ]] && [[ ! "${lib_ver}" =~ "libtorrent-v2.0." ]]; then
				tput sgr0; clear
				warn "qBittorrent $qb_ver is not compatible with libtorrent $lib_ver"
				warn "qBittorrent $qb_ver is compatible with libtorrent-v1.2.x or libtorrent-v2.0.x only"
				warn "Please choose a compatible version"
				lib_ver_choose
			else
				break
			fi
		done
	fi
}

qb_install_check(){
	# Check if qBittorrent version and libtorrent version are supported
	## Check if the qBittorrent version is supported
	if [[ ! " ${qb_name_list[@]} " =~ " ${qb_ver} " ]]; then
		warn "qBittorrent $qb_ver is not supported"
		qb_ver_choose
	fi
	## Check if the libtorrent version is supported
	if [[ ! " ${lib_name_list[@]} " =~ " ${lib_ver} " ]]; then
		warn "libtorrent $lib_ver is not supported"
		lib_ver_check
	fi
	## Check if the libtorrent version is compatible with qBittorrent version
	lib_ver_check
}


install_qBittorrent_(){
	username=$1
	password=$2
	qb_ver=$3
	lib_ver=$4
	qb_cache=$5
	qb_port=$6
	qb_incoming_port=$7

	## Install dependencies for Alpine Linux if needed
	if [ -f /etc/alpine-release ]; then
		# Install required packages for Alpine
		apk add --no-cache wget ca-certificates
		if [ $? -ne 0 ]; then
			warn "Failed to install dependencies for Alpine Linux"
			return 1
		fi
		# Check if user exists
		if ! id "$username" &>/dev/null; then
			warn "User $username does not exist"
			return 1
		fi
	else
		# For non-Alpine systems, check if user exists
		if ! id "$username" &>/dev/null; then
			warn "User $username does not exist"
			return 1
		fi
	fi

	## Check if qBittorrent is running
	if pgrep -i -f qbittorrent; then
		warn "qBittorrent is running. Stopping it now..."
		pkill -s $(pgrep -i -f qbittorrent)
	fi
	# Check if it is still running
	if pgrep -i -f qbittorrent; then
		warn "Failed to stop qBittorrent. Please stop it manually"
		return 1
	fi

	## Check if qbittorrent-nox is installed
	if test -e /usr/bin/qbittorrent-nox; then
		warn "qBittorrent is already installed. Replacing it now..."
		rm /usr/bin/qbittorrent-nox
	fi

	## Download qBittorrent-nox executable
	# Determine the CPU architecture
	if [[ $(uname -m) == "x86_64" ]]; then
		arch="x86_64"
	elif [[ $(uname -m) == "aarch64" ]]; then
		arch="ARM64"
	else
		warn "Unsupported CPU architecture"
		return 1
	fi
	wget https://raw.githubusercontent.com/ctfox66/Seedbox-Components/main/Torrent%20Clients/qBittorrent/$arch/$qb_ver%20-%20$lib_ver/qbittorrent-nox -O $HOME/qbittorrent-nox && chmod +x $HOME/qbittorrent-nox
	#Check if the download is successful
	if [ $? -ne 0 ]; then
		warn "Failed to download qBittorrent-nox executable"
		return 1
	fi

	# Install qbittorrent-nox
	mv $HOME/qbittorrent-nox /usr/bin/qbittorrent-nox
	mkdir -p /home/$username/qbittorrent/Downloads && chown -R $username:$username /home/$username/qbittorrent/
    mkdir -p /home/$username/.config/qBittorrent && chown $username:$username /home/$username/.config/qBittorrent

	# Create service (Alpine Linux uses OpenRC, others use systemd)
	if [ -f /etc/alpine-release ]; then
		# Alpine Linux - OpenRC service
		if test -e /etc/init.d/qbittorrent-nox.$username; then
			warn "qBittorrent OpenRC service already exist. Removing it now..."
			rm /etc/init.d/qbittorrent-nox.$username
		fi
		touch /etc/init.d/qbittorrent-nox.$username
		cat << EOF >/etc/init.d/qbittorrent-nox.$username
#!/sbin/openrc-run

description="qBittorrent service for $username"
command="/usr/bin/qbittorrent-nox"
command_user="$username:$username"
command_background=true
pidfile="/run/qbittorrent-nox.$username.pid"
command_args="--webui-port=$qb_port"
depend() {
	need net
	after network
}

start_pre() {
	checkpath -d -o $username:$username -m 0755 /run
	checkpath -f -o $username:$username -m 0644 /run/qbittorrent-nox.$username.pid
}

stop() {
	ebegin "Stopping qBittorrent for $username"
	if [ -f "$pidfile" ]; then
		kill -TERM $(cat "$pidfile") 2>/dev/null
		sleep 2
		kill -KILL $(cat "$pidfile") 2>/dev/null
	fi
	eend $?
}
EOF
		chmod +x /etc/init.d/qbittorrent-nox.$username
		rc-update add qbittorrent-nox.$username default
		/etc/init.d/qbittorrent-nox.$username start
	else
		# Other distributions - systemd service
		if test -e /etc/systemd/system/qbittorrent-nox@.service; then
			warn "qBittorrent systemd services already exist. Removing it now..."
			rm /etc/systemd/system/qbittorrent-nox@.service
		fi
		touch /etc/systemd/system/qbittorrent-nox@.service
		cat << EOF >/etc/systemd/system/qbittorrent-nox@.service
[Unit]
Description=qBittorrent
After=network.target

[Service]
Type=simple
User=$username
LimitNOFILE=infinity
ExecStart=/usr/bin/qbittorrent-nox 
ExecStop=/usr/bin/killall -w -s 9 /usr/bin/qbittorrent-nox
Restart=on-failure
TimeoutStopSec=20
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
		systemctl enable qbittorrent-nox@$username
		systemctl start qbittorrent-nox@$username
	fi

	## Configure qBittorrent
	# Check for Virtual Environment since some of the tunning might not work on virtual machine
	if [ -f /etc/alpine-release ]; then
		# Alpine Linux - use different virtualization detection
		if [ -f /proc/1/cgroup ] && grep -q docker /proc/1/cgroup 2>/dev/null; then
			warn "Virtualization is detected, skipping some of the tunning"
			aio=8
			low_buffer=3072
			buffer=15360
			buffer_factor=200
		elif [ -f /proc/cpuinfo ] && grep -q hypervisor /proc/cpuinfo 2>/dev/null; then
			warn "Virtualization is detected, skipping some of the tunning"
			aio=8
			low_buffer=3072
			buffer=15360
			buffer_factor=200
		else
			#Determine if it is a SSD or a HDD
			disk_name=$(printf $(lsblk | grep -m1 'disk' | awk '{print $1}'))
			disktype=$(cat /sys/block/$disk_name/queue/rotational)
			if [ "${disktype}" == 0 ]; then
				aio=12
				low_buffer=5120
				buffer=20480
				buffer_factor=250
			else
				aio=4
				low_buffer=3072
				buffer=10240
				buffer_factor=150
			fi
		fi
	else
		# Other distributions - use systemd-detect-virt
		systemd-detect-virt > /dev/null
		if [ $? -eq 0 ]; then
			warn "Virtualization is detected, skipping some of the tunning"
			aio=8
			low_buffer=3072
			buffer=15360
			buffer_factor=200
		else
			#Determine if it is a SSD or a HDD
			disk_name=$(printf $(lsblk | grep -m1 'disk' | awk '{print $1}'))
			disktype=$(cat /sys/block/$disk_name/queue/rotational)
			if [ "${disktype}" == 0 ]; then
				aio=12
				low_buffer=5120
				buffer=20480
				buffer_factor=250
			else
				aio=4
				low_buffer=3072
				buffer=10240
				buffer_factor=150
			fi
		fi
	fi

	# Editing qBittorrent settings
    # Stop service based on OS
    if [ -f /etc/alpine-release ]; then
        /etc/init.d/qbittorrent-nox.$username stop 2>/dev/null || true
    else
        systemctl stop qbittorrent-nox@$username 2>/dev/null || true
    fi

    if [[ "${qb_ver}" =~ "5.1." ]]; then
        md5password=$(echo -n $password | md5sum | awk '{print $1}')
        cat << EOF >/home/$username/.config/qBittorrent/qBittorrent.conf
[Application]
FileLogger\Age=1
FileLogger\AgeType=1
FileLogger\Backup=true
FileLogger\DeleteOld=true
FileLogger\Enabled=true
FileLogger\MaxSizeBytes=66560

[BitTorrent]
Session\AsyncIOThreadsCount=$aio
Session\ConnectionSpeed=9000
Session\DiskQueueSize=10485760
Session\ExcludedFileNames=
Session\FilePoolSize=10000
Session\MaxConnections=50000
Session\MaxConnectionsPerTorrent=10000
Session\MaxUploads=20000
Session\MaxUploadsPerTorrent=4000
Session\PeerTurnover=0
Session\PeerTurnoverCutOff=30
Session\PeerTurnoverInterval=30
Session\Port=$qb_incoming_port
Session\QueueingSystemEnabled=false
Session\RequestQueueSize=5000
Session\SSL\Port=60703
Session\SSRFMitigation=false
Session\SuggestMode=true
Session\ValidateHTTPSTrackerCertificate=false
Session\DefaultSavePath=/home/$username/qbittorrent/Downloads/
Session\SendBufferLowWatermark=$low_buffer
Session\SendBufferWatermark=$buffer
Session\SendBufferWatermarkFactor=$buffer_factor

[Core]
AutoDeleteAddedTorrentFile=Never

[LegalNotice]
Accepted=true

[Meta]
MigrationVersion=8

[Preferences]
Connection\ResolvePeerCountries=false
General\Locale=zh_CN
MailNotification\req_auth=true
WebUI\AuthSubnetWhitelist=@Invalid()
WebUI\CSRFProtection=false
WebUI\ClickjackingProtection=false
WebUI\HostHeaderValidation=false
WebUI\Password_PBKDF2="@ByteArray(klcE8vbtUzDphRZ5MSj5fQ==:5kpWpt5grgskKHlV1FO3Yb/DpCOVkINLNFWT0WInl6EES4RqCVEYatg/aq0P2PKU7QhFxwcn03OIuQc6/0Lumg==)"
WebUI\Port=$qb_port
WebUI\SecureCookie=false

[RSS]
AutoDownloader\DownloadRepacks=true
AutoDownloader\SmartEpisodeFilter=s(\\d+)e(\\d+), (\\d+)x(\\d+), "(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})", "(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})"
EOF
    elif [[ "${qb_ver}" =~ "4.2."|"4.3." ]]; then
        wget  https://raw.githubusercontent.com/ctfox66/Seedbox-Components/main/Torrent%20Clients/qBittorrent/$arch/qb_password_gen -O $HOME/qb_password_gen && chmod +x $HOME/qb_password_gen
        #Check if the download is successful
		if [ $? -ne 0 ]; then
			warn "Failed to download qb_password_gen"
			#Clean up
			rm -r /home/$username/qbittorrent/Downloads
			rm -r /home/$username/.config/qBittorrent
			rm /usr/bin/qbittorrent-nox
			if [ -f /etc/alpine-release ]; then
				rm -f /etc/init.d/qbittorrent-nox.$username
			else
				rm -f /etc/systemd/system/qbittorrent-nox@.service
			fi
			return 1
		fi
		PBKDF2password=$($HOME/qb_password_gen $password)
        cat << EOF >/home/$username/.config/qBittorrent/qBittorrent.conf
[BitTorrent]
Session\AsyncIOThreadsCount=$aio
Session\SendBufferLowWatermark=$low_buffer
Session\SendBufferWatermark=$buffer
Session\SendBufferWatermarkFactor=$buffer_factor

[LegalNotice]
Accepted=true

[Network]
Cookies=@Invalid()

[Preferences]
Connection\PortRangeMin=$qb_incoming_port
Downloads\DiskWriteCacheSize=$qb_cache
Downloads\SavePath=/home/$username/qbittorrent/Downloads/
Queueing\QueueingEnabled=false
WebUI\Password_PBKDF2="@ByteArray($PBKDF2password)"
WebUI\Port=$qb_port
WebUI\Username=$username
EOF
	rm qb_password_gen
    elif [[ "${qb_ver}" =~ "4.4."|"4.5."|"4.6." ]]; then
        wget  https://raw.githubusercontent.com/ctfox66/Seedbox-Components/main/Torrent%20Clients/qBittorrent/$arch/qb_password_gen -O $HOME/qb_password_gen && chmod +x $HOME/qb_password_gen
        #Check if the download is successful
		if [ $? -ne 0 ]; then
			warn "Failed to download qb_password_gen"
			#Clean up
			rm -r /home/$username/qbittorrent/Downloads
			rm -r /home/$username/.config/qBittorrent
			rm /usr/bin/qbittorrent-nox
			if [ -f /etc/alpine-release ]; then
				rm -f /etc/init.d/qbittorrent-nox.$username
			else
				rm -f /etc/systemd/system/qbittorrent-nox@.service
			fi
			return 1
		fi
		PBKDF2password=$($HOME/qb_password_gen $password)
        cat << EOF >/home/$username/.config/qBittorrent/qBittorrent.conf
[Application]
MemoryWorkingSetLimit=$qb_cache

[BitTorrent]
Session\AsyncIOThreadsCount=$aio
Session\DefaultSavePath=/home/$username/qbittorrent/Downloads/
Session\DiskCacheSize=$qb_cache
Session\Port=$qb_incoming_port
Session\QueueingSystemEnabled=false
Session\SendBufferLowWatermark=$low_buffer
Session\SendBufferWatermark=$buffer
Session\SendBufferWatermarkFactor=$buffer_factor

[LegalNotice]
Accepted=true

[Network]
Cookies=@Invalid()

[Preferences]
WebUI\Password_PBKDF2="@ByteArray($PBKDF2password)"
WebUI\Port=$qb_port
WebUI\Username=$username
EOF
    rm qb_password_gen
    fi
    # Start service based on OS
    if [ -f /etc/alpine-release ]; then
        /etc/init.d/qbittorrent-nox.$username start
    else
        systemctl start qbittorrent-nox@$username
    fi
}

return 0