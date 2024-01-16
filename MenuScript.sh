#!/bin/bash
#Script name: myscript.sh
#Purpose:Create a bash script file for the purpose of user and group management in Linux. The script will be run with elevated permissions.
#Written by: Tsaichun Chang 041095591
#Date: 2023-11-28


#Purpose: Display the menu
#Date: 2023-11-28
#Algorithm: Print out the menu,
#	    1 for creating new user account
#	    2 Change Initial Group for a user
#	    3 Change Supplementary Group for a user
#	    4 Change default login shell
#	    5 Change account expiration date
#	    6 Delete a user account
#	    q|Q Quit
function displayMenu()
{
    clear
    echo "************************************************************"
    echo "                User Administration Menu"
    echo " "
    echo "1. To Create a user account"
    echo "2. To Change Initial Group for a user account"
    echo "3. To Change Supplementary Group for a user account"
    echo "4. To Change default login shell for a user account"
    echo "5. To Change account expiration date for a user account"
    echo "6. To Delete a user account"
    echo "Q to Quit"
    echo "************************************************************"
    echo " "
}

#Purpose: Add a new user
#Date: 2023-11-28
#Algorithm: Receive read's input to three variables - name, homeDir, loginSh
#	    Using name, homeDir, loginSh as arguments to add a new user
#	    IF there is an error with your user arguments
#	       Print the error messages
#	       Sleep for 4 secs
#	    ELSE
#	       Print the successful messages and print the created user information
#	       Sleep for 4 secs
#	    ENDIF
function addUser(){ 
	 read -p "a. Username: " name
         read -p "b. User’s home directory (using absolute path): " homeDir
         read -p "c. Default login shell (using absolute path): " loginSh

         useradd -d $homeDir -m -s $loginSh $name
	
	 if [ $? != 0 ]
	 then
		echo "There is an error with your user arguments, returning to the menu."
		sleep 4
	 else
		echo -e "\nUser successfully created: " ; cat /etc/passwd | grep -E $name
		sleep 4
	 fi
}

#Purpose: Change initial group
#Date: 2023-11-28
#Algorithm: Receive read's input to two variables - name, newInGroup
#           Using name, newInGroup as arguments to change the initial group for the user
#           IF there is an error with your user arguments
#              Print the error messages
#              Sleep for 4 secs
#           ELSE
#              Print the successful messages and print the created user group information
#              Sleep for 4 secs
#           ENDIF
function newInGroup()
{
	read -p "a. User name: " name
	read -p "b. New group name: " newInGroup

	usermod -g $newInGroup $name

	if [ $? != 0 ]
	then
		echo "There is an error with your user arguments, returning to the menu."
                sleep 4
        else
		echo -e "Initial group successfully changed. Initial group is now \c"; id -gn $name
                sleep 4
        fi
}

#Purpose: Change supplementary group
#Date: 2023-11-28
#Algorithm: Receive read's input to two variables - name, newSuGroup
#           Using name, newInGroup as arguments to change the supplementary group for the user
#           IF there is an error with your user arguments
#              Print the error messages
#              Sleep for 4 secs
#           ELSE
#              Print the successful messages and print the user supplementary group information
#              Sleep for 4 secs
#           ENDIF
function newSuGroup()
{
	read -p "a. User name: " name
        read -p "b. New supplementary group name: " newSuGroup
  
        usermod -G $newSuGroup $name
  
        if [ $? != 0 ]
        then
               echo "There is an error with your user arguments, returning to the menu."
               sleep 4
        else
               echo -e "\nSupplementary group successfully changed. Supplementary groups now are \c"; id -Gn $name
               sleep 4
        fi
}

#Purpose: Change default shell for a user
#Date: 2023-11-28
#Algorithm: Receive read's input to two variables - name, newDeShell
#           Using name, newDeShell as arguments to change the default shell for the user
#           IF there is an error with your user arguments
#              Print the error messages
#              Sleep for 4 secs
#           ELSE
#              Print the successful messages and print the user default shell information
#              Sleep for 4 secs
#           ENDIF
function newDeShell()
{
	read -p "a. User name: " name
	read -p "b. New default login shell(absolute path): " newDeShell

	chsh -s $newDeShell $name
 
        if [ $? != 0 ]
        then
               echo "There is an error with your user arguments, returning to the menu."
               sleep 4
        else
               echo -e "\nNew default login shell successfully changed: "  
	       cat /etc/passwd | grep -E $name
               sleep 4
        fi
}

#Purpose: Change expiration date for a user
#Date: 2023-11-28
#Algorithm: Receive read's input to two variables - name, newExpDate
#           Using name, newExpDate as arguments to change the expiration date for the user
#           IF there is an error with your user arguments
#              Print the error messages
#              Sleep for 4 secs
#           ELSE
#              Print the successful messages
#              Sleep for 4 secs
#           ENDIF
function newExpDate()
{
	read -p "Username: " name
        read -p "New expiration date (YYYY-MM-DD): " newExpDate

	usermod -e $newExpDate $name

	if [ $? != 0 ]
        then
               echo "There is an error with your user arguments, returning to the menu."
               sleep 4
        else
               echo -e "\nNew expiration date successfully changed. "
               sleep 4
        fi
}

#Purpose: Delete a user
#Date: 2023-11-28
#Algorithm: Receive read's input to one variable - name
#           Using name as argument to delete the user and its home directory
#           IF there is an error with your user arguments
#              Print the error messages
#              Sleep for 4 secs
#           ELSE
#              Print the successful messages
#              Sleep for 5 secs
#           ENDIF
function delUser()
{
	read -p "a. User name: " name

        userdel $name
	rm -rf "/home/$name"

        if [ $? != 0 ]
        then
               echo "There is an error with your user arguments, returning to the menu."
               sleep 4
        else
               echo "User account $name deleted along with the home directory."  
               sleep 5
        fi
}

#Purpose: Quit the loop
#Date: 2023-11-28
#Algorithm: Change the variable value to y to end the loop 
function quit()
{
	stop="y"
}

#Purpose: Use a while loop to display user a menu and execute what user request
#Date: 2023-11-28
#Algorithm:Set a variable "stop" to control the loop 
#	   Enter a while loop
#	   Call diaplayMenu function
#	   Receive read's input to one variable - option
#	   Case option in
#	   1 call the addUser function
#	   2 call the newInGroup fuction
#	   3 call the newSuGroup fuction
#	   4 call the newDeShell fuction
#	   5 call the newExpDate fuction
#	   6 call the delUser fuction
#	   q|Q call the quit fuction
#	   End Case
#	   End Loop
stop=N
while [[ $stop != "y" ]]
do

displayMenu;

read -p "Choose one of the following options, shown above, by entering the appropriate number: " option

case $option in
	[1]) addUser ;;
	[2]) newInGroup ;;
	[3]) newSuGroup ;;
	[4]) newDeShell ;;
	[5]) newExpDate ;;
	[6]) delUser ;;
	q|Q) quit ;;
esac

done
   