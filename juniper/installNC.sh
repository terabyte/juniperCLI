
# Install the service

if [ "$#" -lt "1" ]
then
	echo "Insufficiant number of parameters"
	echo "$0 <install dir>"
	exit;
fi

if [ -e "$1/ncsvc" ] 
then
	echo "Service needs to be reinstalled."
else
	echo "Service needs to be installed for the first time."
fi

ok="try"
until [ "$ok" = "done" ]
do
	echo "Please enter the root/su password"
	su root -c "install -m 6711 -o root $1/../tmp/ncsvc $1/ncsvc"
	if [ "$?" -eq "0" ] 
	then
		cp $1/../tmp/version.txt $1/
		ok="done"
		rm -rf $1/../tmp
	else 
		echo "Invalid su password and/or Unable to install ncsvc"
		echo -n "Do you want to try again (enter y to try again):";
		read choice;		
		if [ "$choice" != "y" ]
		then 
			ok="done"
		fi
	fi
done
chmod 744 $1/ncdiag
