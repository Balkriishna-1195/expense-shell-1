#!/bin/bash

source ./common.sh

Check_root

echo "Please enter DB password"
read -s mysql_root_password


dnf install mysql-sertyghver -y &>> $LOGFILE
#VALIDATE $? "Installing mysql server"

systemctl enable mysqld &>> $LOGFILE
#VALIDATE $? "enabling mysql server"

systemctl start mysqld  &>> $LOGFILE
#VALIDATE $? "Starting mysql server"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>> $LOGFILE
# VALIDATE $? "Setting up root password"

# Below code will be useful for idempotent nature
mysql -h db.balkriishna.online -uroot -p${mysql_root_password} -e 'show databases;' &>> $LOGFILE
if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>> $LOGFILE
    #VALIDATE &? "MySQL root password setup"
else 
    echo -e "mysql toot password is already setup.. $Y Skipping $N"
fi