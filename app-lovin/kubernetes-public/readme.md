

/* not always is needed.
if you get  ipv6 error , run this command
sudo -i

export APIS="googleapis.com www.googleapis.com storage.googleapis.com iam.googleapis.com container.googleapis.com cloudresourcemanager.googleapis.com"
for i in $APIS
do
  echo "199.36.153.10 $i" >> /etc/hosts
done

exit
*/