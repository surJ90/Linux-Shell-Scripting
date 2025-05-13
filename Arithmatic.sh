a=10
b=5
((sum=a+b))
echo $sum
((diff=a-b))
echo $diff
((mul=a*b))
echo $mul
((div=a/b))
echo $div

# Using let
let "let_sum = a + b"
echo $let_sum

# floating point
result=$(echo "10.5 / 2" | bc -l) # bc should be installed > sudo apt-get install bc
echo $result

height=1.75
weight=70
bmi=$(echo "$weight / ($height * $height)" | bc -l)
printf "BMI: %.2f\n" "$bmi"