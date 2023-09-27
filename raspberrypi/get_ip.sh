github_user="ExzoZbta"
github_repo="CPSC-334"

folder="/home/student334/CPSC-334/raspberrypi"
filename="ip.md"

ip_address=$(hostname -I)

echo "$ip_address" > "$folder/$filename"

cd "$folder" || exit
git config user.email "exzozbta@gmail.com"
git config user.name "ExzoZbta"
git add "$filename"
git commit -m "Update IP address" --allow-empty
git push origin main

echo "Current IP address ($ip_address) has been saved."
