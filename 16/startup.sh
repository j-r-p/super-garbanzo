echo $(dirname $0)
docker-compose -f $(dirname $0)/docker-compose.yml up -d
#read -p "Press enter to continue"
#docker-compose -f $(dirname $0)/hbusa/docker-compose.yml up -d
docker-compose -f $(dirname $0)/sbrmala/docker-compose.yml up -d
docker-compose -f $(dirname $0)/modulesnow/docker-compose.yml up -d
docker-compose -f $(dirname $0)/ytwusa/docker-compose.yml up -d
docker-compose -f $(dirname $0)/proxy/docker-compose.yml up -d
