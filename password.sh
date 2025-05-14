echo "Password generator"
echo "Enter the length of the password: "
read pass_len

for p in $(seq 1 5)
do
    openssl rand -base64 48 | cut -c1-$pass_len
done