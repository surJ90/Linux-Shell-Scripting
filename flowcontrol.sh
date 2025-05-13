is_active="false"
if [ "$is_active" = "true" ];
then
    echo "Server is active"
else
    echo "Server is down"
fi

read -p "Enter a number: " num
((rem=($num)%2))
if [ "$rem" = "0" ];
then
    echo "Even number"
else 
    echo "Odd number"
fi