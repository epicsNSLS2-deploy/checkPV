#!/bin/bash 

while [ 0 -eq 0 ]
    do  
caget $1
while [ $? -eq 0 ]

do

 
    echo "$var" >> file
    var=$(caget $1)
    




#date "+%Y-%m-%d_%H-%M-%S"
#2019-03-22_17-35-48

 
    

done

if [ $? -ne 0 ]; then
    

    now=$(date "+%Y-%m-%d_%H-%M-%S")
    echo "$var" >> file
    echo "pv disconnected at-------$now" >> file



fi






    
    
done  

	  

