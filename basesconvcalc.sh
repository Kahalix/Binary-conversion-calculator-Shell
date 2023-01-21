#! /bin/bash
for (( u=0; u<1; u++ ))
do
        printf "napisz 1 jesli chcesz wykonac konwersje systemu, a 2 jesli chcesz wykonac dzialania na systemach\n"
        read -r wybor
        if [ $wybor == 1 ]
        then
                for (( u1=0; u1<1; u1++ ))
                do
                	printf "podaj z jakiego systemu przechodzisz: "
                	read -r sys1
                	if ! [[ "$sys1" =~ ^[0-9]+$ ]]
                	then
                                u1=-1
                                printf "bledna wartosc\n"
                        fi
                done
                for (( u2=0; u2<1; u2++ ))
                do
                	printf "podaj wartosc liczbowa: "
        	        read -r wartosc
                	if ! [[ "$wartosc" =~ ^[0-9]+$ ]]
                	then
                                u2=-1
                                printf "bledna wartosc\n"
                        fi
                done
                for (( u3=0; u3<1; u3++ ))
                do
                        for (( u5=0; u5<1; u5++ ))
                        do
                                printf "w odstepach podaj na jakie systemy ma byc wykonana konwersja\n"
                                read -r c
                                if [[ -z "$c" ]]
                                then
                                        printf "bledna wartosc\n"
                                        u5=-1                                     
                               fi
                        done
        	        lista=($c)
                        dlugosc=${#lista[@]}
                        for (( z=0; z<$dlugosc; z++))
                        do
                	if ! [[ "${lista[$z]}" =~ ^[0-9]+$ ]]
                	then
                                u3=-1
                                printf "bledna wartosc\n"
                        fi
                        done
                done
                for (( z=0; z<$dlugosc; z++))
                do
        		printf "podana wartosc w systemie ${lista[$z]} wynosi: "
                        a="obase=${lista[$z]};ibase=$sys1;$wartosc"
                        echo $a | bc
                done
                        read -p "Nacisnij enter aby zakonczyc dzialanie programu"
        elif [ $wybor == 2 ]
        then
                for (( u3=0; u3<1; u3++ ))
                do
                	for (( u5=0; u5<1; u5++ ))
                        do
                                printf "w odstepach podaj na jakie systemy ma byc wykonana konwersja\n"
                                read -r c
                                if [[ -z "$c" ]]
                                then
                                        printf "bledna wartosc\n"
                                        u5=-1                                     
                               fi
                        done
        	        lista=($c)
                        dlugosc=${#lista[@]}
                        for (( z=0; z<$dlugosc; z++))
                        do
                	if ! [[ "${lista[$z]}" =~ ^[0-9]+$ ]]
                	then
                                u3=-1
                                printf "bledna wartosc\n"
                        fi
                        done
                done
                for (( z=0; z<$dlugosc; z++))
                do
        		if [ $z != 0 ]
        		then
                                for (( u4=0; u4<1; u4++ ))
                                do
                                        printf "podaj odpowiednie dzialanie (+ - * /)\n"
                                        read -r dzialanie
                                        if [[ "$dzialanie" != '+' && "$dzialanie" != '-' && "$dzialanie" != '*' && "$dzialanie" != '/' ]]
                                        then
                                                u4=-1
                                                printf "bledny znak\n"
                                        fi
                                done
        		fi
        		for (( u1=0; u1<1; u1++ ))
                        do
                        	printf "podaj wartosc systemu ${lista[$z]}: "
                                read -r g
                        	if ! [[ "$g" =~ ^[0-9]+$ ]]
                        	then
                                        u1=-1
                                        printf "bledna wartosc\n"
                                fi
                        done
        	        h=$(bc <<< "obase=10;ibase=${lista[$z]};$g")
                        if [ $z == 0 ]
                        then
                                a=$h
                        else
                                if [ "$dzialanie" == '*' ]
                                then
                		        a=$((a*h))
                		elif [ "$dzialanie" == '/' ]
                		then
                		        a=$((a/h))
                		elif [ "$dzialanie" == '+' ]
                		then
                		        a=$((a+h))
                		elif [ "$dzialanie" == '-' ]
                		then
                		        a=$((a-h))
                		fi
                        fi
                done
                for (( u2=0; u2<1; u2++ ))
                do
                	printf "W jakim systemie ma byc wyswietlony wynik\n"
                        read -r finalbase
                	if ! [[ "$finalbase" =~ ^[0-9]+$ ]]
                	then
                        u1=-1
                        printf "bledna wartosc\n"
                        fi
                done
               	finalres=$(bc <<< "obase=$finalbase;ibase=10;$a")
                printf "wynik w systemie $finalbase to: $finalres\n"
        	read -p "Nacisnij enter aby zakonczyc dzialanie programu"
        else
                u=-1
                printf "bledna wartosc\n"
        fi
done
