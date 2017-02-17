#! /bin/bash
echo "Press '1' to setup a ZFS pool"
echo "or press '2' to setup up BTRFS"
read -n1 -r -p "You choose!" key

if [ "$key" = "1" ]; then
	# installing ZFS on Ubuntu
	# install apt-add-repo
	echo "You have chosen ZFS"
	echo "adding zfs repo"
	apt-get install python-software-properties
	
	# add zfs repo
	apt-add-repository --yes ppa:zfs-native/stable
	
	echo "repo added, time to update system"
	sleep 3
	apt-get update
	
	# install zfs
	echo "installing zfs"
	sleep 3
	apt-get install ubuntu-zfs
	
	# test kernel for correctly compiled
	dmesg | grep zfs
	
	# shows disks to add to ZFS array
	fdisk -l | grep /dev/

	read -n1 -r -p "raidz 1 or raidz 2? \n pick 1 or 2" pool

	if [ "$pool" = "1" ]; then	
		# creates raidz1 pool
		echo "raidz1 selected!"
		zpool create -f data raidz /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf
	
		# checks pool
		zpool status data
	elif [ "$pool" = "2" ]; then
		# creates raidz2 pool
		echo "raidz2 selected!"
		zpool create -f data raidz2 /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf

		# checks pool
		zpool status data
	fi
	# mounts pool
	echo "mounting your pool"
	zfs create -o mountpoint=/media/test data/test
elif [ "$key" = "2" ]; then
	echo "You have chosen BTRFS"
	echo "installing BTRFS"
	apt-get install btrfs-tools

	echo "creating btrfs filesystem!"
	sleep 3
	mkfs.btrfs -d raid1 /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf

	echo "here is your new filesystem!"
	btrfs filesystem show
	sleep 3

	echo "mounting your filesystem"

else
	echo "You didn't press '1' or '2'"
	echo "Goodbye"
fi