#!/system/bin/sh
#
# 
# Kludgy hack to help with kernels
clear
echo "Max CPU Clock selection:" 
echo
echo "1) 1.67ghz"
echo "2) 1.62ghz"
echo "3) 1.56ghz"
echo "4) 1.51ghz"
echo "Choose number selection[99 = abort][0 = default:1.67ghz]:"
read maxkhz
        case "$maxkhz" in
                "0")
                        maxkhz=1674000
                        maxkhz2="1.67ghz"
                        ;;
                "1")
                        maxkhz=1674000
                        maxkhz2="1.67ghz"
                        ;;
                "2")
                        maxkhz=1620000
                        maxkhz2="1.62ghz"
                        ;;
                "3")
                        maxkhz=1566000
                        maxkhz2="1.56ghz"
                        ;;
                "4")
                        maxkhz=1512000
                        maxkhz2="1.51ghz"
                        ;;
                "99")
			exit
                        ;;
        esac
clear
echo "Min CPU Clock selection:" 
echo
echo "1) 486mhz"
echo "2) 432mhz"
echo "3) 384mhz"
echo "4) 192mhz"
echo "Choose number selection[99 = abort][0 = default:384mhz]:"
read minkhz
        case "$minkhz" in
                "0")
                        minkhz=384000
                        minkhz2="384mhz"
                        ;;
                "1")
                        minkhz=486000
                        minkhz2="486mhz"
                        ;;
                "2")
                        minkhz=432000
                        minkhz2="432mhz"
                        ;;
                "3")
                        minkhz=384000
                        minkhz2="384mhz"
                        ;;
                "4")
                        minkhz=192000
                        minkhz2="192mhz"
                        ;;
                "99")
			exit
                        ;;
        esac
clear
echo "Max Screen Off CPU Clock selection:" 
echo
echo "1) 702mhz"
echo "2) 648mhz"
echo "3) 594mhz"
echo "4) 540mhz"
echo "5) 486mhz"
echo "Choose number selection[99 = abort][0 = default:486mhz:"
read maxscroff
        case "$maxscroff" in
                "0")
                        maxscroff=486000
                        maxscroff2="486mhz"
                        ;;
                "1")
                        maxscroff=702000
                        maxscroff2="702mhz"
                        ;;
                "2")
                        maxscroff=648000
                        maxscroff2="648mhz"
                        ;;
                "3")
                        maxscroff=594000
                        maxscroff2="594mhz"
                        ;;
                "4")
                        maxscroff=540000
                        maxscroff2="540mhz"
                        ;;
                "5")
                        maxscroff=486000
                        maxscroff2="486mhz"
                        ;;
                "99")
			exit
                        ;;
        esac
clear
echo "Governor selection:"
echo 
echo "1) Intellidemand"
echo "2) Lionheart"
echo "3) Wheatley"
echo "4) Lulzactive"
echo "5) DanceDance"
echo "6) Scary"
echo "7) BadAss"
echo "8) Lazy"
echo "9) Lagfree"
echo "Choose number selection[99 = abort][0 = default:Intellidemand]:"
read gov
	case "$gov" in
                "0")
                        gov=intellidemand
                        gov2="Intellidemand"
                        ;;
                "1")
                        gov=intellidemand
                        gov2="Intellidemand"
                        ;;
                "2")
                        gov=Lionheart
                        gov2="LionHeart"
                        ;;
                "3")
                        gov=wheatley
                        gov2="Wheatley"
                        ;;
                "4")
                        gov=lulzactive
                        gov2="Lulzactive"
                        ;;
                "5")
                        gov=dancedance
                        gov2="DanceDance"
                        ;;
                "6")
                        gov=scary
                        gov2="Scary"
                        ;;
                "7")
                        gov=badass
                        gov2="BadAss"
                        ;;
                "8")
                        gov=lazy
                        gov2="Lazy"
                        ;;
                "9")
                        gov=lagfree
                        gov2="Lagfree"
                        ;;
                "99")
			exit
                        ;;
	esac
clear
echo "IO Scheduler selection:"
echo 
echo "1) SIO"
echo "2) No-op"
echo "3) Deadline"
echo "4) Row"
echo "Choose number selection[99 = abort][0 = default:SIO]:"
read scheduler
	case "$scheduler" in
                "0")
                        scheduler=sio
                        ;;
                "1")
                        scheduler=sio
                        ;;
                "2")
                        scheduler=noop
                        ;;
                "3")
                        scheduler=deadline
                        ;;
                "4")
                        scheduler=row
                        ;;
                "99")
			exit
                        ;;
	esac
clear
echo "Sweep2Wake selection:"
echo 
echo "1) Disable"
echo "2) Enable"
echo "3) Enable w/o button lights"
echo "Choose number selection[99 = abort][0 = default:Disabled]:"
read s2w
	case "$s2w" in
                "0")
                        s2w=0
			s2w2=disabled
                        ;;
                "1")
                        s2w=0
			s2w2=disabled
                        ;;
                "2")
                        s2w=1
			s2w2=withlights
                        ;;
                "3")
                        s2w=2
			s2w2=nolights
                        ;;
                "99")
			exit
                        ;;
	esac
clear
echo "Last chance before we flash" 
echo "Options chosen are $maxkhz2 $minkhz2 $maxscroff2 $gov2 $scheduler S2w $s2w2"
echo 
echo "1) Yes; I am ready flash it right away"
echo "2) No; let's just save it for later"
echo "Confirm flash?"
read confirm
	case "$confirm" in
		"1")
			clear
			cd /sdcard
			if [ ! -d "/temp" ]; then
			mkdir temp
			fi
			cd temp
			dd if=/dev/block/mmcblk0p22 of=/sdcard/temp/tempboot.img
			/sbin/abootimg -x /sdcard/temp/tempboot.img
			sed -i '/cmdline = / d' bootimg.cfg
			echo "cmdline = console=ttyHSL3 androidboot.hardware=vigor no_console_suspend=1 gov="$gov "maxkhz="$maxkhz "minkhz="$minkhz "scheduler="$scheduler "maxscroff="$maxscroff "s2w="$s2w"" >> bootimg.cfg
			/sbin/abootimg -u /sdcard/temp/tempboot.img -f /sdcard/temp/bootimg.cfg
			dd if=/sdcard/temp/tempboot.img of=/dev/block/mmcblk0p22
			rm bootimg.cfg
			rm initrd.img
			rm zImage
			if [ ! -d "/sdcard/lunar" ]; then
			mkdir /sdcard/lunar
			fi
			if [ ! -e /sdcard/lunar/boot_"$maxkhz2"_"$minkhz2"_"$maxscroff2"_"$gov2"_"$scheduler"_s2w"$s2w2".img ]; then
			mv /sdcard/temp/tempboot.img /sdcard/lunar/boot_"$maxkhz2"_"$minkhz2"_"$maxscroff2"_"$gov2"_"$scheduler"_s2w"$s2w2".img
			echo "Flashed new boot and created at"
			echo "/sdcard/lunar/boot_"$maxkhz2"_"$minkhz2"_"$maxscroff2"_"$gov2"_"$scheduler"_s2w"$s2w2".img"
			else
			echo "Configuration already exists; aborting copy to /sdcard/lunar"
			rm tempboot.img
			fi
			;;
                "2")
			echo "Aborted flash!"
			cd /sdcard
			if [ ! -d "/temp" ]; then
			mkdir temp
			fi
			cd temp
			dd if=/dev/block/mmcblk0p22 of=/sdcard/temp/tempboot.img
			/sbin/abootimg -x /sdcard/temp/tempboot.img
			sed -i '/cmdline = / d' bootimg.cfg
			echo "cmdline = console=ttyHSL3 androidboot.hardware=vigor no_console_suspend=1 gov="$gov "maxkhz="$maxkhz "minkhz="$minkhz "scheduler="$scheduler "maxscroff="$maxscroff "s2w="$s2w"" >> bootimg.cfg
			/sbin/abootimg -u /sdcard/temp/tempboot.img -f /sdcard/temp/bootimg.cfg
			rm bootimg.cfg
			rm initrd.img
			rm zImage
			if [ ! -d "/sdcard/lunar" ]; then
			mkdir /sdcard/lunar
			fi
			if [ ! -e /sdcard/lunar/boot_"$maxkhz2"_"$minkhz2"_"$maxscroff2"_"$gov2"_"$scheduler"_s2w"$s2w2".img ]; then
			mv /sdcard/temp/tempboot.img /sdcard/lunar/boot_"$maxkhz2"_"$minkhz2"_"$maxscroff2"_"$gov2"_"$scheduler"_s2w"$s2w2".img
			echo "I just saved your boot LOL"
			echo "It is saved here /sdcard/lunar/boot_"$maxkhz2"_"$minkhz2"_"$maxscroff2"_"$gov2"_"$scheduler"_s2w"$s2w2".img"
			echo "Run 'sh /sbin/menu.sh' to flash"
			else
			echo "Configuration already exists; aborting copy to /sdcard/lunar"
			rm tempboot.img
			fi
			echo "Come back soon!"
			exit
                        ;;
	esac
$confirm
