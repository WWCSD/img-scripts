#!/bin/bash

#############################################################
# Automated imaging script by Adam Rochette and Jeff Stasko #
#############################################################

###ADAM SUCKS BALLS###

mount -t nfs 10.91.16.173:/pxework/work/bin /testbin -o ro  > /dev/null 2>&1
mount -t nfs 10.91.16.82:/home/administrator/ProductInfo /computers/ProductInfo -o ro > /dev/null 2>&1
mount -t nfs 10.91.16.82:/home/administrator/ImagePath /computers/ImagePath -o ro > /dev/null 2>&1
mount -t nfs 10.91.16.82:/home/administrator/MachineTypes /computers/MachineTypes -o ro > /dev/null 2>&1
mount -t nfs 10.91.16.82:/Images /images -o ro  > /dev/null 2>&1

setterm -clear;

RenameDesktop()
{
SelectBuilding;
EnterRoomType;
EnterRoom;
ComputerNumber;
}

RenamePortable()
{
SelectBuilding;
EnterCart;
ComputerNumber;
}

SelectBuilding()
{
BLDG="";
INPUT="";
echo -e "01......\033[36m Adams \033[0m";
echo -e "02......\033[0m Board Office \033[0m";
echo -e "03......\033[36m Buildings & Grounds \033[0m";
echo -e "04......\033[31m Edison \033[0m";
echo -e "05......\033[31m Elliott \033[0m";
echo -e "06......\033[32m Franklin \033[0m";
echo -e "07......\033[36m Hamilton \033[0m";
echo -e "08......\033[31m Hicks \033[0m";
echo -e "09......\033[32m Hoover \033[0m";
echo -e "10......\033[0m John Glenn \033[0m";
echo -e "11......\033[31m Marshall \033[0m";
echo -e "12......\033[33m PD Graham \033[0m";
echo -e "13......\033[35m Roosevelt-McGrath \033[0m";
echo -e "14......\033[36m Schweitzer \033[0m";
echo -e "15......\033[33m Stevenson \033[0m";
echo -e "16......\033[35m Stottlemyer \033[0m";
echo -e "17......\033[33m Taft-Galloway \033[0m";
echo -e "18......\033[31m Tinkham \033[0m";
echo -e "19......\033[36m Walker-Winter \033[0m";
echo -e "20......\033[0m Wayne Memorial \033[0m";
echo -e "21......\033[0m William D. Ford \033[0m";
echo -e "22......\033[35m Wildwood \033[0m";
echo -e -n "\033[32mSelect the building: \033[0m";
read INPUT;

case $INPUT in
	01|1)
	    BLDG="AUE"	
	    MSOFFICE="2000"
	    ;;
	02|2)
	    BLDG="BRD"
	    SelectOffice
	    ;;
	03|3)
	    BLDG="BNG"
	    SelectOffice
	    ;;
	04|4)
	    BLDG="EDIS"
	    MSOFFICE="XP"
	    ;;
	05|5)
	    BLDG="ELLI"
	    MSOFFICE="2000"
	    ;;
	06|6)
	    BLDG="FMS"
        MSOFFICE="XP" 
        ;;
	07|7)
	    BLDG="HAMI"
	    MSOFFICE="2000"
	    ;;
	08|8)
	    BLDG="HICK"
	    MSOFFICE="2000"
	    ;;
	09|9)
	    BLDG="HOOV"
	    MSOFFICE="2000"
	    ;;
	10)
	    BLDG="JGHS"
	    MSOFFICE="XP"
	    ;;
	11)
	    BLDG="MUE"
	    MSOFFICE="XP"
	    ;;
	12)
	    BLDG="PDG"
	    MSOFFICE="2000"
	    ;;
	13)
	    BLDG="ROOS"
	    MSOFFICE="2000"
	    ;;
	14)
	    BLDG="SCHW"
	    MSOFFICE="2000"
	    ;;
	15)
	    BLDG="SMS"
	    MSOFFICE="XP"
	    ;;
	16)
	    BLDG="STOT"
	    SelectOffice
	    ;;
	17)
	    BLDG="TAFT"
	    MSOFFICE="2000"
	    ;;
	18)
	    BLDG="TINK"
	    MSOFFICE="XP"
	    ;;
	19)
	    BLDG="WALK"
	    MSOFFICE="2000"
	    ;;
	20)
	    BLDG="WMHS"
	    MSOFFICE="XP"
	    ;;
	21)
	    BLDG="FCTC"
	    MSOFFICE="2003"
	    ;;
	22)
	    BLDG="WILD"
	    MSOFFICE="XP"
	    ;;
	*)
	    echo -e "\033[31mPlease enter a valid selection! \033[0m \n"
	    SelectBuilding 
	    ;;

esac
}

### SELECT VERSION OF MICROSOFT OFFICE ###
SelectOffice()
{
echo -e -n "1...2000\n";
echo -e -n "2...XP\n";
echo -e -n "3...2003\n";
echo -e -n "4...2007\n";
echo -e -n "Just Hit Enter if you want skip the office add-on\n";
echo -e -n "\033[32mPlease select the version of \033[0mMicrosoft Office\033[32m you want to install: \033[0m"
 
read OFFICEVER;

case $OFFICEVER in
	1)
	    MSOFFICE="2000" ;;
	2)
	    MSOFFICE="XP" ;;
	3)
	    MSOFFICE="2003" ;;
	4)
	    MSOFFICE="2007" ;;
	"")
		MSOFFICE="" ;;
	*)
	    echo -e -n "\033[31mPlease enter a valid selection! \033[0m \n"
	    SelectOffice
	    ;;
esac
}

### THIS WILL SET THE ROOMTYPE FOR DESKTOPS TO LAB OR CLASSROOM ###
EnterRoomType()
{
ROOMTYPE="";
echo -e -n "\033[32mIs this a (l)ab or (c)lassroom? \033[0m";
read ROOMTYPE;
	case $ROOMTYPE in
		c|C)
			;;
		l|L)
			;;
		*)
			echo -e "\033[31mPlease enter \033[0m(l)\033[31m or \033[0m(c)\033[31m! \033[0m \n"
			EnterRoomType
			;;
	esac
}

### ENTER ROOM NUMBER FOR A DESKTOP COMPUTER ###
EnterRoom()
{
ROOM="";
echo -e -n "\033[32mEnter the room number or name: \033[0m";
read ROOM;
case $ROOM in
	1)
	    ROOM=01 ;;
	2)
	    ROOM=02 ;;
	3)
	    ROOM=03 ;;
	4)
	    ROOM=04 ;;
	5)
	    ROOM=05 ;;
	6)
	    ROOM=06 ;;
	7)
	    ROOM=07 ;;
	8)
	    ROOM=08 ;;
	9)
	    ROOM=09 ;;
	"")
	    echo -e "\033[31mPlease enter a valid room number! \033[0m \n"
	    EnterRoom
	    ;;
esac

ROOM=$(echo -e $ROOM | tr a-z A-Z);
}

### ENTER CART NUMBER OR NAME FOR LAPTOPS ### 
EnterCart()
{
CART="";
echo -e -n "\033[32mEnter the cart number: \033[0m ";
read CART;
case $CART in
	1)
	    CART=01 ;;
	2)
	    CART=02 ;;
	3)
	    CART=03 ;;
	4)
	    CART=04 ;;
	5)
	    CART=05 ;;
	6)
	    CART=06 ;;
	7)
	    CART=07 ;;
	8)
	    CART=08 ;;
	9)
	    CART=09 ;;
	"")
	    echo -e "\033[31m Please enter a valid cart number! \033[0m "
	    EnterCart
	    ;;
esac
}

### ENTER COMPUTER NUMBER FOR DESKTOPS OR LAPTOPS ####
ComputerNumber()
{
COMP="";
echo -e -n "\033[32mEnter the computer number: \033[0m";
read COMP;

case $COMP in
	1)
	    COMP=01 ;;
	2)
	    COMP=02 ;;
	3)
	    COMP=03 ;;
	4)
	    COMP=04 ;;
	5)
	    COMP=05 ;;
	6)
	    COMP=06 ;;
	7)
	    COMP=07 ;;
	8)
	    COMP=08 ;;
	9)
	    COMP=09 ;;
	"")
            echo -e "\033[31mPlease enter a valid computer number! \033[0m \n"
	    ComputerNumber 
	    ;;
esac

COMP=$(echo -e $COMP | tr a-z A-Z);
}

### CONFIRMATION FOR DESKTOPS: USES BLDG ROOM COMP FOR NAME: USES ROOMTYPE FOR WORKGROUP ###
dConfirm()
{
echo -e -n "\033[33mComputer name will be set to "$BLDG"-"$ROOM"-"$COMP" ...is this OK? (y or n): \033[0m";
read CONFIRMATION;
case $CONFIRMATION in
	y|Y|"")
	    zisedit ComputerName=$BLDG"-"$ROOM"-"$COMP
	    zisedit DNSHostName=$BLDG"-"$ROOM"-"$COMP
       	zisedit DNSSuffix=wwcsd.net
			case $ROOMTYPE in
				c|C)
				zisedit WindowsWorkGroup=$BLDG
				;;
				l|L)
				zisedit WindowsWorkGroup=$BLDG"-LAB-"$ROOM
				;;
	    	esac
	    ;;
    n|N)
	    RenameDesktop
	    dConfirm
	    ;;
	*)
	    echo -e "\033[31mPlease enter y or n! \033[0m \n"
	    dConfirm
	    ;;
esac
}

### CONFIRMATION FOR PORTABLES: USES BLDG CARTTYPE(SET BY MACHINE AUTOMATICALLY) CART COMP FOR NAME: USES BLDG - PORTABLE FOR WORKGROUP ###
pConfirm()
{
echo -e -n "\033[33mComputer name will be set to "$BLDG"-"$CARTTYPE$CART"-"$COMP" ...is this OK? (y or n): \033[0m";
read CONFIRMATION;
case $CONFIRMATION in
	y|"")
	    zisedit ComputerName=$BLDG"-"$CARTTYPE$CART"-"$COMP
	    zisedit WindowsWorkGroup=$BLDG"-PORTABLE"
	    zisedit DNSHostName=$BLDG"-"$CARTTYPE$CART"-"$COMP
        zisedit DNSSuffix=wwcsd.net
        MSOFFICE=""
	    ;;
	n)
	    RenamePortable
	    pConfirm
	    ;;
	*)
	    echo -e "\033[31mPlease enter y or n! \033[0m \n"
	    pConfirm
	    ;;
esac
}

###THIS WILL SEARCH FOR THE NAME OF A COMPUTER JUST BEING IMAGED. IF IT DOESN'T FOLLOW BLDG-ROOM-## IT WILL ASK YOU FOR BLDG AND ROOM ###
getName()
{
BLDG=`zisview ComputerName | sed -n 's/.*\(^[A-Za-z]*\)-.*/\1/gp'`
case $BLDG in
	AUE)
	    BLDG="AUE"	
		MSOFFICE="2000"
		;;
	BRD)
	    BLDG="BRD"
	    SelectOffice
	    ;;
	BNG)
	    BLDG="BNG"
	    SelectOffice
	    ;;
	EDIS)
	    BLDG="EDIS"
	    MSOFFICE="XP"
	    ;;
	ELLI)
	    BLDG="ELLI"
	    MSOFFICE="2000"
	    ;;
	FMS)
	    BLDG="FMS"
        MSOFFICE="XP" 
        ;;
	HAMI)
	    BLDG="HAMI"
	    MSOFFICE="2000"
	    ;;
	HICK)
	    BLDG="HICK"
	    MSOFFICE="2000"
	    ;;
	HOOV)
	    BLDG="HOOV"
	    MSOFFICE="2000"
	    ;;
	JGHS)
	    BLDG="JGHS"
	    MSOFFICE="XP"
	    ;;
	MUE)
	    BLDG="MUE"
	    MSOFFICE="XP"
	    ;;
	PDG)
	    BLDG="PDG"
	    MSOFFICE="2000"
	    ;;
	ROOS)
	    BLDG="ROOS"
	    MSOFFICE="2000"
	    ;;
	SCHW)
	    BLDG="SCHW"
	    MSOFFICE="2000"
	    ;;
	SMS)
	    BLDG="SMS"
	    MSOFFICE="XP"
	    ;;
	STOT)
	    BLDG="STOT"
	    SelectOffice
	    ;;
	TAFT)
	    BLDG="TAFT"
	    MSOFFICE="2000"
	    ;;
	TINK)
	    BLDG="TINK"
	    MSOFFICE="XP"
	    ;;
	WALK)
	    BLDG="WALK"
	    MSOFFICE="2000"
	    ;;
	WMHS)
	    BLDG="WMHS"
	    MSOFFICE="XP"
	    ;;
	FCTC)
	    BLDG="FCTC"
	    MSOFFICE="2003"
	    ;;
	WILD)
	    BLDG="WILD"
	    MSOFFICE="XP"
	    ;;
	*)
		echo -e -n "\nThe Script Could not determine the BUILDING you are in by the computer name. \nPlease Select the Building you are in, (this isn't going to rename the machine): \n"
		SelectBuilding
		SelectOffice
		;;
esac

ROOM=`zisview ComputerName | sed -n 's/.*-\([0-9A-Za-z]*\)-.*/\1/gp'`
case $ROOM in
	"")
		echo -e -n "\nThe script could not determine the ROOM you are in by the computer name. \nPlease enter the Room you are in, (this isn't going to rename the machine): \n"
		EnterRoom
		;;
esac
}


### THIS SHOULD BE REMOVED EVENTUALLY BUT IT IS TO LOAD THE TUXERA NTFS DRIVER TO RESTORE A NETWORK IMAGE TO A MACHINE ###	


#tuxDriver()
#{
#echo -e -n "\n\033[33mDo you want to use the\033[0m Tuxera NTFS Driver \033[33mto restore/multicast your image?\033[0m  (y or n) \n\033[32mThe default answer is \033[0mNO\033[32m please just \033[0mHIT ENTER\033[32m if you are unsure: \033[0m";
#read tDriver;
#case $tDriver in
#	y|Y)
#		tftp -m binary 10.91.16.170 -c get tntfs.ko /modules/tntfs.ko > /dev/null 2>&1
#		insmod /modules/tntfs.ko > /dev/null 2>&1
#		Image
#	    ;;
#	n|N|"")
#	    Image
#	    ;;
#	*)
#	    echo -e "\033[31mPlease enter \033[0m\n(y)\033[31m or \033[0m\n(n)\033[31m! \033[0m \n"
#	    tuxDriver
#	    ;;
#esac
#}
###

freezeComputer()
{
Frozen=""
echo -e -n "\n\033[33mDo you want to\033[0m Freeze \033[33mor Leave the Computer\033[0m Thawed \033[33mfor 5 reboots?\033[0m\n\033[33mPlease enter\033[0m f \033[33mfor\033[0m Freeze \033[33mor\033[0m t \033[33mfor\033[0m Thaw \033[33mfor 5 reboots.\033[0m";
read fComputer;
case $fComputer in
	f|F|"")
		Frozen=""
		Image
		;;
	t|T)
		Frozen=thaw.zmg
		Image
		;;
	*)
		echo -e "\033[31mPlease enter f for (freeze) or t for(thaw)! \033[0m \n"
	    freezeComputer
	    ;;
esac
}

sbTools()
{
LoadSBTools=""
echo -e -n "\n\033[33mDo you want to have the machine load\033[0m Smart Board Tools \033[33mon startup? (y or n, default is n)\033[0m \n"
read sbLoad;
case $sbLoad in
    y|Y)
        LoadSBTools=sbtools.zmg
        ;;
    n|N|"")
        LoadSBTools=""
        ;;
    *)
        echo -e "\033[3mPlease enter y or n!\033[33m \n"
        sbTools
        ;;
esac
}

### THIS WILL ALLOW YOU TO CONFIRM OR CHANGE YOUR MULTICAST SESSION NAME AND START YOUR MULTICAST ###
Multicast()
{
echo -e -n "\033[33mUse\033[0m "$mSession" \033[33mas your session name...is this OK?\033[0m  (y or n) \n\033[32mIf you say\033[0m (n) \033[32myou will be prompted for a session name: \033[0m";
read mConfirmation;
case $mConfirmation in
	y|Y|"")
		##Office Selection for Multicast Only###
		SelectOffice
		img session $mSession
	    ;;
	n|N)
	    echo -e -n "\033[33mEnter a Session Name: \033[0m\n";
	    read mSession
	    Multicast
	    ;;
	*)
	    echo -e "\033[31mPlease enter y or n! \033[0m \n"
	    Multicast
	    ;;
esac
}

### THIS WILL RESTORE A NETWORK IMAGE FROM H2 USING IMGPATH(THIS IS STORED IN THE TEXT FILE WITH THE PRODUCT ID FOR THE MACHINE YOU ARE ON; IT CAN BE BLANK) ###
Imaging()
{
echo -e -n "\033[33mUse\033[0m "$IMGPATH" \033[33mas your image...is this OK?  (y or n) \nIf you say n you will be prompted for a image name: \033[0m";
read iConfirmation;
case $iConfirmation in
	y|Y|"")
		img rp 10.91.16.82 $IMGPATH
	    ;;
	n|N)
	    select ImagesPath in `ls -lR /images/*.zmg | awk '{if ( $1 ~ /\./) print $1; else { print $9}}' | sed -e 's/^[/images/\t]*//'`
		do
			IMGPATH=$ImagesPath;
			break;
		done
	    Imaging
	    ;;
	*)
	    echo -e "\033[31mPlease enter \033[0m\n(y)\033[31m or \033[0m\n(n)\033[31m! \033[0m \n"
	    Imaging
	    ;;
esac
}

### THIS WILL ASK YOU TO SELECT IF YOU WANT TO PULL DOWN A NETWORK IMAGE OR IF YOU WANT TO START/JOIN A MULTICAST SESSION ###
Image()
{
echo -e -n "\033[33mDo you want to \033[0mMulticast(m)\033[33m or \033[0mPull Down A Network Image(i)\033[33m?\n\033[32mPlease enter \033[0m(m)\033[32m or \033[0m(i)\033[32m: \033[0m ";
read TYPE;
case $TYPE in
	m|M)
		echo -e -n "\033[33mEnter a Session Name: \033[0m\n";
        read mSession
        Multicast
		;;
	i|I)
		Imaging
		;;
	*)
	    echo -e "\033[31mPlease enter \033[0m(m)\033[31m or \033[0m(i)\033[31m \033[0m!"
	    Image
	    ;;
esac
}

### THIS IS FOR NEW COMPUTERS/COMPUTERS WE DONT HAVE THE /tmp/hwinfo.bios FOR YET AND NEED TO BE RENAMED: IT WILL ASK YOU IF YOU ARE ON DESKTOP, LAPTOP, NETBOOK: IT WILL SET CARTTYPE FOR PORTABLES ###
ComputerType()
{
echo -e -n "\n\033[33mAre you on a \033[0mDesktop (d)\033[33m or \033[0mLaptop (l)\033[33m or \033[0mNetbook (n)\033[33m?\n\033[32mPlease enter \033[0m(d)\033[32m or \033[0m(l)\033[32m or \033[0m(n)\033[32m:\033[0m ";
read StationType;
case $StationType in
	d|D)
		RenameDesktop
		dConfirm
		;;
	l|L)
		CARTTYPE="C"
		RenamePortable
		pConfirm
		MSOFFICE=""
		;;
	n|N)
		CARTTYPE="N"
		RenamePortable
		pConfirm
		MSOFFICE=""
		;;
	*)
		echo -e "\033[31mPlease enter \033[0m(d)\033[31m or \033[0m(l)\033[31m or \033[0m(n)\033[31m! \033[0m \n"
	    ComputerType
	    ;;	
esac
}

### IF RENAMING A MACHINE IT WILL CLEAR OUT THE IMAGE SAFE DATA  AND SELECT PROPER FUNCTION TO RENAME OR LOAD THE COMPUTER TYPE FUNCTION TO ASK YOU WHAT TYPE OF COMPUTER YOU ARE ON ###
Rename()
{
dd if=/dev/zero of=/dev/hda bs=512 seek=5 count=58 > /dev/null 2>&1;
dd if=/dev/zero of=/dev/sda bs=512 seek=5 count=58 > /dev/null 2>&1;

if grep "$compModel" /computers/MachineTypes/workstations.xP > /dev/null 2>&1;then
RenameDesktop;
dConfirm;
elif grep "$compModel" /computers/MachineTypes/workstations.7 > /dev/null 2>&1;then
RenameDesktop;
dConfirm;
elif grep "$compModel" /computers/MachineTypes/hub.7 > /dev/null 2>&1;then
RenameDesktop;
dConfirm;
MSOFFICE="";
elif grep "$compModel" /computers/MachineTypes/laptops.xP > /dev/null 2>&1;then
CARTTYPE="C";
RenamePortable;
pConfirm;
MSOFFICE="";
elif grep "$compModel" /computers/MachineTypes/netbooks.xP > /dev/null 2>&1;then
CARTTYPE="N";
RenamePortable;
pConfirm;
MSOFFICE="";
elif grep "$compModel" /computers/MachineTypes/netbooks.7 > /dev/null 2>&1;then
CARTTYPE="N";
RenamePortable;
pConfirm;
MSOFFICE="";
elif grep "$compModel" /computers/MachineTypes/laptops.7 > /dev/null 2>&1;then
CARTTYPE="C";
RenamePortable;
pConfirm;
MSOFFICE="";
else
ComputerType;
fi
}

### DISPLAYS COMPUTER NAME AND WORKGROUP: THAN ASKS IF YOU WANT TO RENAME AND IMAGE, RENAME, IMAGE AND LOADS PROPER FUNCTIONS BASED ON CHOICE ###
Selector()
{
echo -e -n "\033[31mYour Machine Name is \033[0m\n";
zisview ComputerName;
echo -e -n "\n\033[31mand the WorkGroup is \033[0m\n";
zisview WindowsWorkGroup;
echo -e -n "\n\033[33mDo you want to \033[0mRename and Image (1)\033[33m or \033[0mImage (2)\033[33m or \033[0mRename (3)\033[33m?\n\033[32mPlease enter \033[0m(1)\033[32m or \033[0m(2)\033[32m or \033[0m(3)\033[32m:\033[0m ";
read OPTION;
case $OPTION in
	1)
		Rename
		#tuxDriver
		### PLEASE UNCOMMENT tuxDriver AND REMOVE freezeComputer if you need to use the tuxDriver Selection ###
        sbTools
		freezeComputer
		;;
	2)
		getName
		#tuxDriver
		### PLEASE UNCOMMENT tuxDriver AND REMOVE freezeComputer if you need to use the tuxDriver Selection ###
        sbTools
		freezeComputer
		;;
	3)
		Rename
		;;
	*)
		echo -e "\033[31mPlease enter \033[0m(1)\033[31m or \033[0m(2)\033[31m or \033[0m(3)\033[31m! \033[0m \n"
	    Selector
	    ;;
esac
}

### Due to number of model variations this making sure we have bios for each type of model out there ###
machineCheck=""
export machineCheck=`cat /tmp/hwinfo.bios | grep -i Product: | tail -n1 | sed -e 's/^[Product: "\t]*//;s/[ "]//g'`

if grep "$machineCheck" /computers/MachineTypes/* > /dev/null 2>&1; then
IMGPATH="";
else
cd /tmp;
cp /tmp/hwinfo.bios /;
export imgModel=`cat /tmp/hwinfo.bios | grep -i Product: | head -n1 | sed 's/[^0-9]//g'`;
tftp -m ascii 10.91.16.82 -c put hwinfo.bios $imgModel"hwinfo.bios" > /dev/null 2>&1;
fi

#These lines use the variable compModel to grep the /tmp/hwinfo.bios files to pick 
#a script to run based on the compModel variable
compModel=""
export compModel=`cat /tmp/hwinfo.bios | grep -i Product: | head -n1 | sed -e 's/^[Product: "\t]*//;s/[ "]//g'`

#Using new variable compModel to determine product number: we will print the $compModel(variable that will change based on machine you are on) and only return the last line which will give us the image to restore to the machine ###

if grep "$compModel" /computers/MachineTypes/laptops.xP > /dev/null 2>&1; then
IMGPATH=`cat /computers/MachineTypes/laptops.xP | tail -n1`;
elif grep "$compModel" /computers/MachineTypes/netbooks.xP > /dev/null 2>&1;then
IMGPATH=`cat /computers/ProductInfo/$compModel | tail -n1`;
elif grep "$compModel" /computers/MachineTypes/workstations.xP > /dev/null 2>&1; then
IMGPATH=`cat /computers/MachineTypes/workstations.xP | tail -n1`;
elif grep "$compModel" /computers/MachineTypes/hub.7 > /dev/null 2>&1;then
IMGPATH=`cat /computers/ProductInfo/$compModel | tail -n1`;
elif grep "$compModel" /computers/MachineTypes/laptops.7 > /dev/null 2>&1;then
IMGPATH=`cat /computers/ProductInfo/$compModel | tail -n1`;
elif grep "$compModel" /computers/MachineTypes/workstations.7 > /dev/null 2>&1;then
IMGPATH=`cat /computers/ProductInfo/$compModel | tail -n1`;
else
IMGPATH="unknownMachineType";
fi

if grep "$compModel" /computers/ProductInfo/OptiPlex390 > /dev/null 2>&1; then
tftp -m binary 10.91.16.171 -c get tntfs.ko /modules/tntfs.ko > /dev/null 2>&1;
insmod /modules/tntfs.ko > /dev/null 2>&1;
echo "Tux Driver Loaded"
fi

Selector;


### THIS IF STATEMENT WILL SET MSOFFICE TO BLANK IF THE MACHINE IS A NETBOOK OR LAPTOP OR HUB ###
if grep "$compModel" /computers/MachineTypes/hub.7 > /dev/null 2>&1;then
MSOFFICE="";
elif grep "$compModel" /computers/MachineTypes/laptops.xP > /dev/null 2>&1;then
MSOFFICE="";
elif grep "$compModel" /computers/MachineTypes/netbooks.xP > /dev/null 2>&1;then
MSOFFICE="";
elif grep "$compModel" /computers/MachineTypes/netbooks.7 > /dev/null 2>&1;then
MSOFFICE="";
elif grep "$compModel" /computers/MachineTypes/laptops.7 > /dev/null 2>&1;then
MSOFFICE="";
fi

### ADD-ON Scripts: Should restore based on choices made through the rest of the selection ###
img rp 10.91.16.82 /addon/Drivers/$compModel;
img rp 10.91.16.82 /addon/$BLDG/$BLDG;
img rp 10.91.16.82 /addon/Office/$MSOFFICE;
img rp 10.91.16.82 /addon/$BLDG/$ROOM;
img rp 10.91.16.82 /addon/$Frozen;
img rp 10.91.16.82 /addon/$LoadSBTools;
img rp 10.91.16.82 /addon/nojava.zmg

#shutdown -r now;
