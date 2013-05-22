#!/system/bin/sh
#
# 
# Kludgy hack to help with kernels
boot=$(grep -i "boot" /proc/emmc | sed 's/.*boot\(.*\)<\/recovery.*/\1/' | sed 's/:[^:]*$//')
recovery=$(grep -i "recovery" /proc/emmc | sed 's/.*boot\(.*\)<\/recovery.*/\1/' | sed 's/:[^:]*$//')
#Let's not rely on static values, we will get them from emmc hardware instead

DATE=$(date +"%m%d%y")
if [ ! -d "/sdcard/lunar" ]; then
mkdir /sdcard/lunar
fi
cd /sdcard/lunar
echo
echo "1) Flash a previously saved boot.img"
echo "2) Flash a recovery.img"
echo "3) Flash an AnyKernel zImage"
echo
echo "Choose number selection[99 = abort]:"
read menu
        case "$menu" in
                "1")
			grep_cmd=`find ./boot* | grep -i \\.img$`
			echo "Previous configurations:" 
			echo
			for filename in $grep_cmd 
			    do
 			     count=$(($count+1))

 			     filename=`echo $filename | sed 's/temp_space/ /g'`

   			   # Store file names in an array
     			 file_array[$count]=$filename

			      echo "  ($count) $filename" >> temp.list
  			  done

  			  more temp.list
 			  rm temp.list

			    echo
			    echo -n "Enter selection number to flash (exit = 0): "

    			read enterNumber
    			echo
			if [ "$enterNumber" == "0" ]
    			then
      			exit 0
			fi
			if [ "`echo $enterNumber | sed 's/[0-9]*//'`" == "" ] || [ "enterNumber"=="1" ]
    			then
      			file_chosen=${file_array[$enterNumber]}
			fi
			echo "Last chance before we flash" 
			echo "You chose $file_chosen"
			echo 
			echo "1) Yes; I am ready flash it right away"
			echo "2) No; let's just save it for later"
			echo "Confirm flash?"
			read confirm
			case "$confirm" in
				"1")
					echo "Flashing selection in ..."
					echo "5"
					sleep 1
					echo "4"
					sleep 1
					echo "3"
					sleep 1
					echo "2"
					sleep 1
					echo "1"
					sleep 1
					dd if=$file_chosen of=/dev/block/$boot
					echo "Please Reboot to recovery....."
					echo ".... and Wipe Dalvik Cache & Cache"
					echo "GoodBye!"
					exit
					;;
				"2")
					echo "Fine, I will be here when you get back :)"
					echo "This message will self-destruct in ..."
					echo "5"
					sleep 1
					echo "4"
					sleep 1
					echo "3"
					sleep 1
					echo "2"
					sleep 1
					echo "1"
					sleep 1
					echo "P O O F!"
					exit
					;;
			esac
		$confirm
		;;
                "2")
			grep_cmd=`find ./recovery* | grep -i \\.img$`
			echo "Recoveries found:" 
			echo
			for filename in $grep_cmd 
			    do
 			     count=$(($count+1))

 			     filename=`echo $filename | sed 's/temp_space/ /g'`

   			   # Store file names in an array
     			 file_array[$count]=$filename

			      echo "  ($count) $filename" >> temp.list
  			  done

  			  more temp.list
 			  rm temp.list

			    echo
			    echo -n "Enter selection number to flash (exit = 0): "

    			read enterNumber
    			echo
			if [ "$enterNumber" == "0" ]
    			then
      			exit 0
			fi
			if [ "`echo $enterNumber | sed 's/[0-9]*//'`" == "" ] || [ "enterNumber"=="1" ]
    			then
      			file_chosen=${file_array[$enterNumber]}
			fi
			echo "Last chance before we flash" 
			echo "You chose $file_chosen"
			echo 
			echo "1) Yes; I am ready flash it right away"
			echo "2) No; let's just save it for later"
			echo "Confirm flash?"
			read confirm
			case "$confirm" in
				"1")
					echo "Backup current recovery?"
					echo "1) Yes"
					echo "2) No"
					read backup
					case "$backup" in
						"1")
							echo "Input name of recovery backup [Aa-Zz|0-9]:"
							read recoverybackup
							dd if=/dev/block/$recovery of=/sdcard/lunar/recovery_$recoverybackup_$DATE.img
							echo "Your current recovery was saved to SDCard/Lunar dir as recovery_$recoverybackup_$DATE.img"
							;;
						"2")
							echo "Skipping creation of a recovery backup"
							;;
					esac
					$backup
					echo "Flashing selection in ..."
					echo "5"
					sleep 1
					echo "4"
					sleep 1
					echo "3"
					sleep 1
					echo "2"
					sleep 1
					echo "1"
					sleep 1
					dd if=$file_chosen of=/dev/block/$recovery
					echo "Please Reboot to recovery....."
					echo ".... and Wipe Dalvik Cache & Cache"
					echo "GoodBye!"
					exit
					;;
				"2")
					echo "Fine, I will be here when you get back :)"
					echo "This message will self-destruct in ..."
					echo "5"
					sleep 1
					echo "4"
					sleep 1
					echo "3"
					sleep 1
					echo "2"
					sleep 1
					echo "1"
					sleep 1
					echo "P O O F!"
					exit
					;;
			esac
			$confirm
			;;
		"3")
			grep_cmd=`find zimage*`
			echo "zImages found:" 
			echo
			for filename in $grep_cmd 
			    do
 			     count=$(($count+1))

 			     filename=`echo $filename | sed 's/temp_space/ /g'`

   			   # Store file names in an array
     			 file_array[$count]=$filename

			      echo "  ($count) $filename" >> temp.list
  			  done

  			  more temp.list
 			  rm temp.list

			    echo
			    echo -n "Enter selection number to flash (exit = 0): "

    			read enterNumber
    			echo
			if [ "$enterNumber" == "0" ]
    			then
      			exit 0
			fi
			if [ "`echo $enterNumber | sed 's/[0-9]*//'`" == "" ] || [ "enterNumber"=="1" ]
    			then
      			file_chosen=${file_array[$enterNumber]}
			fi
			echo "Last chance before we flash" 
			echo "You chose $file_chosen"
			echo 
			echo "1) Yes; I am ready flash it right away"
			echo "2) No; let's just save it for later"
			echo "Confirm flash?"
			read confirm
			case "$confirm" in
				"1")
					echo "Flashing selection in ..."
					echo "5"
					sleep 1
					echo "4"
					sleep 1
					echo "3"
					sleep 1
					echo "2"
					sleep 1
					echo "1"
					sleep 1
					sum1=$(sha1sum $file_chosen | cut -d ' ' -f 1)
					if [ ! -d "/sdcard/temp" ]; then
					#-- Checking if temp exists if not we will create it
					mkdir /sdcard/temp
					fi
					dd if=/dev/block/$boot of=/sdcard/temp/tempboot.img
					abootimg -x /sdcard/temp/tempboot.img
					sum2=$(sha1sum zImage | cut -d ' ' -f 1)
					cp /sdcard/temp/tempboot.img /sdcard/lunar/boot_last_known_good.img
					echo "Pulled a copy of your current boot.img to lunar/boot_last_known_good.img"
					#-- The next line is dependent on the placement of abootimg
					cd /sdcard/lunar
					abootimg -u /sdcard/temp/tempboot.img -k $file_chosen
					cd /sdcard/temp
					dd if=/sdcard/temp/tempboot.img of=/dev/block/$boot
					dd if=/dev/block/$boot of=/sdcard/temp/tempboot.img
					abootimg -x /sdcard/temp/tempboot.img
					sum3=$(sha1sum zImage | cut -d ' ' -f 1)
					echo "$file_chosen sha1sum is $sum1"
					echo "Current zImage sha1sum is $sum2"
					if [ "$sum3" == "$sum1" ]; then
					echo "flashed ok"
					currentboot=$(echo $file_chosen | sed -e "s|zimage|boot_currentrom_|")
					echo "Copy of your updated boot.img is at lunar/$currentboot.img"
					mv /sdcard/temp/tempboot.img /sdcard/lunar/$currentboot.img
					fi
					if [ "$sum3" == "$sum2" ]; then
					echo "flash unsuccessful"
					echo "restoring boot_last_known_good.img"
					dd if=/sdcard/lunar/boot_last_known_good.img of=/dev/block/$boot
					fi
					rm zImage
					rm initrd.img
					rm bootimg.cfg
					echo "Please Reboot to recovery....."
					echo ".... and Wipe Dalvik Cache & Cache"
					echo "GoodBye!"
					exit
					;;
				"2")
					echo "Fine, I will be here when you get back :)"
					echo "This message will self-destruct in ..."
					echo "5"
					sleep 1
					echo "4"
					sleep 1
					echo "3"
					sleep 1
					echo "2"
					sleep 1
					echo "1"
					sleep 1
					echo "P O O F!"
					exit
					;;
			esac
		$confirm
		;;
		"99")
			exit
			;;
        esac
$menu
