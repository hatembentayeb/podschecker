#!/bin/bash 

# colores
blanc="\033[1;37m"
gray="\033[0;37m"
magento="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
amarillo="\033[1;33m"
azul="\033[1;34m"
rescolor="\e[0m"

listPods=$(kubectl get po | awk 'NR>1{print $1}')
#echo "$listPods"
readarray  arr <<<  $listPods

ok=0
notok=0
echo -e "\nSit Down and Wait  \U1F602 :\n"
for i in ${arr[@]}
do 
echo -ne "$i ... " 
status=$(kubectl get po $i | grep $i | awk '{print $3}')
	if [[ ! $status =~ ^Running$|^Completed$  ]]  ; then
		echo -e "\e[1;31mOh Shit !"$rescolor""
        notify-send "Pods Health" "$i was  FUCKED" -t 10000 
        let ok=ok+1
	else
		echo -e "\e[1;32mOK!"$rescolor""
        #notify-send "Pod $i Is Good :)"
      let notok=notok+1
	fi
done
echo -e "\nSTATS:\n"
echo "+---------------+---------------+"
printf  "|$green%-15s$rescolor|$red%-15s$rescolor|\n" "Healthy Pods" "Unhealthy Pods"
echo "+---------------+---------------+"
printf  "|%-15s|%-15s|\n" "$ok" "$notok"
echo "+---------------+---------------+"
echo -e "\n"