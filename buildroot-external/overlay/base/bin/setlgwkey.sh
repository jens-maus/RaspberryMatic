#!/bin/sh

# list all keychange files
UPDATEFILES=`ls /etc/config/*.keychange`
# perform key exchange for every keychange file
for F in $UPDATEFILES
do
	echo "Processing update file $F"
	#parse the file
	SERIAL=`cat $F | grep Serial | sed s/Serial=//`
	IP=`cat $F | grep IP | sed s/IP=//`
	KEY=`cat $F | grep KEY | sed s/KEY=//`
	CURKEY=`cat $F | grep CURKEY | sed s/CURKEY=//`
	CLASS=`cat $F | grep Class | sed s/Class=//`

	#Check gateway class and set rfd.conf / hs485d.conf path
	if [ "$CLASS" == "Wired" ] 
	then
	    #Wired
	    CONFFILE=/etc/config/hs485d.conf
    elif [ "$CLASS" == "RF" ] 
    then
    	#RF
    	CONFFILE=/etc/config/rfd.conf
    else 
    	exit 1
    fi

	#Start key exchange
	if [ "$IP" == "" ]
	then
		#echo  "Using Serial"
		eq3configcmd setlgwkey -s $SERIAL -c $CURKEY -n $KEY -f $CONFFILE -l 1	
	else
		#echo "Using IP"
		eq3configcmd setlgwkey -s $SERIAL -h $IP -c $CURKEY -n $KEY -f $CONFFILE -l 1	
	fi

	# On success delete key exchange file
	if [ $? -eq 0 ]
	then
		rm -f $F
	fi
done 


