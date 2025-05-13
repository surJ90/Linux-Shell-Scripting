fruits=("lemon" "pineapple")
fruits+=("orange") # appending
echo ${fruits[@]}

unset fruits[1] # removing an element
echo ${fruits[@]}

# iterating over array
for fruits in "${fruits[@]}"; 
do 
    echo "Fruit: $fruits"
done