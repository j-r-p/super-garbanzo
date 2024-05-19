#read -p "Press enter to continue"
#docker-compose -f hbusa/docker-compose.yml down
docker-compose -f sbrmala/docker-compose.yml down
docker-compose -f modulesnow/docker-compose.yml down
docker-compose -f distillery/docker-compose.yml down
docker-compose -f imgenv/docker-compose.yml down
#docker-compose -f ytwusa/docker-compose.yml down
docker-compose -f proxy/docker-compose.yml down
docker-compose -f docker-compose.yml down
