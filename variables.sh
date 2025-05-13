# read-only variables
declare -r PI=3.14159
echo "$PI"
PI=3.147

# local scope
my_function() {
    local result
    result=2121
    echo "Inside function: $result"
}

my_function
echo "Outside function: ${result:-Undefined}"

# exporting variables
export new_var="Hi"
bash -c "echo $new_var"

# removing sufix/prefix
file="document.txt"
echo "${file%.txt}" # removes sufix
echo "${file#doc}"  # removes prefix

# set to default use = instead of -
echo "${name:=Default}"