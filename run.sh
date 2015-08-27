#!/bin/bash
sudo date
CONTAINER=$(sudo docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro mynew-httpd1 /usr/lib/systemd/systemd)
echo ${CONTAINER}
echo "To enter docker container run: 
        docker exec -t -i ${CONTAINER} /bin/bash"
