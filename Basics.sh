# Datatypes and Variables
# String
name="Suraj"
echo $name

# Integer
age=25
echo $age

# Indexed Array
fruits=("Apple" "Banana" "Orange")
echo ${fruits[0]}

# Associative array
declare -A employee
employee[name]="Suraj"
employee[age]=23
employee[role]="Cloud DevOps"
echo ${employee[name]}

# methods to print
echo $name
echo "$name"
echo "Hello, $name!"

# Printf
Printf "Name: %s, Age: %d\n" "$name" "$age"

# Variable expansion
name="Prashanth"
echo ${name}
echo ${new_name:-Unknown} # if variable is not found prints default value
echo ${#name} # gives length of the string

# String operations
first_name="Suraj"
last_name="Patil"
full_name="$first_name $last_name" # concatnation
echo $full_name 
sub_string=${full_name:0:5}
echo $sub_string
replaced_string=${full_name/Suraj/Sudheer}
echo $replaced_string
upper_name=${full_name^^}
lower_name=${full_name,,}
echo $upper_name
echo $lower_name