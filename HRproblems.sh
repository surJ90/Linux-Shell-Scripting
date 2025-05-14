echo "Hello, World!"

# for ((i=0;i<=100;i++))
# do 
#     ((rem=$i%2))
#     if [ "$rem" -ne "0" ]; then
#         echo "$i"
#     fi
# done 

read -p "Your name: " name
echo "welcome $name!"

# read -p "X: " x
# read -p "Y: " y
# echo $(($x+$y))
# echo $(($x-$y))
# echo $(($x*$y))
# echo $(($x/$y))

read -p "Expression: " exp
result=$(echo "scale=10; $exp" | bc -l)
printf "%.3f\n" "$result"