# docker-rcon
Dockerized rcon cli client

## usage
Best way to start this container is with --rm flag, so container is removed after command is ran. Running command below gives rcon usage

```
docker run -ti --rm kerbe/rcon
```

You specify necessary command line arguments like this:
```
docker run -ti --rm kerbe/rcon -P"rconpassword" -aIP_ADDRESS -pPORT_NUMBER command
```

## usage with other docker containers
Probably you are running your target server as a docker container too, if you are looking for dockerized rcon command line tool. Here are some instructions how to easily figure out correct IP and PORT to use with rcon command line tool.

### Finding IP to connect
When running server in docker container, check it's local ip address with following:
```
# docker inspect dockerContainerName | grep -i ipaddress
"SecondaryIPAddresses": null,
"IPAddress": "172.17.0.2",
    "IPAddress": "172.17.0.2",
```

Example above shows that docker container, which name is dockerContainerName has ip address of 172.17.0.2 (which is default for first running container on host).

### Finding PORT to connect

You can find hint from container's exposed ports, which could be rcon port:
```
# docker inspect dockerContainerName | grep -i port
            "PortBindings": {
                        "HostPort": "27015"
                        "HostPort": "27020"
                        "HostPort": "7777"
                        "HostPort": "7778"
            "PublishAllPorts": false,
            "ExposedPorts": {
            "Ports": {
                        "HostPort": "27015"
                        "HostPort": "27020"
                        "HostPort": "7777"
                        "HostPort": "7778"
```

Above shows that there are four ports exposed (7777, 7778, 27015, 27020) and all four has been binded also. Binding isn't necessary if you are using rcon from same docker host where target container is running, as they can use docker internal network (172.17.0 -network).

In similar fashion you can connect to any remote host, as long as there is public IP and PORT where you can connect.
