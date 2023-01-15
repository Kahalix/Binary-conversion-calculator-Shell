#! /bin/bash
printf "napisz 1 jesli chcesz wykonac konwersje systemu, a 2 jesli chcesz wykonac dzialania na systemach\n"
read -r wybor
if [ $wybor == 1 ]
then
	printf "podaj z jakiego systemu przechodzisz: "
	read -r sys1
	printf "podaj wartosc liczbowa: "
	read -r wartosc
        printf "w odstepach podaj na jakie systemy ma byc wykonana konwersja\n"
        read -r c
	lista=($c)
        dlugosc=${#lista[@]}
        for (( z=0; z<$dlugosc; z++))
        do
		printf "podana wartosc w systemie ${lista[$z]} wynosi: "
                a="obase=${lista[$z]};ibase=$sys1;$wartosc"
                echo $a | bc
        done
                read -p "Nacisnij enter aby zakonczyc dzialanie programu"
elif [ $wybor == 2 ]
then
	printf "w odstepach podaj systemy, ktore beda uzyte do wyliczen (system obliczy wartosci w kolejnosci od pierwszej do ostatniej) \n"
        read -r c
        lista=($c)
        dlugosc=${#lista[@]}
        for (( z=0; z<$dlugosc; z++))
        do
		if [ $z != 0 ]
		then
			 printf "podaj odpowiednie dzialanie (+ - * /)\n"
                        read -r dzialanie
                	if [[ "$dzialanie" != '+' && "$dzialanie" != '-' && "$dzialanie" != '*' && "$dzialanie" != '/' ]]
                        then
                                printf "bledny znak"
                                sleep 5
                                exit
                        fi
		fi
        	printf "podaj wartosc systemu ${lista[$z]}: "
                read -r g
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
	printf "W jakim systemie ma byc wyswietlony wynik\n"
        read -r finalbase
	finalres=$(bc <<< "obase=$finalbase;ibase=10;$a")
        printf "wynik w systemie $finalbase to: $finalres\n"
	read -p "Nacisnij enter aby zakonczyc dzialanie programu"
else
        printf "bledna wartosc"
	sleep 5
fi
