### docker-compose-dns-test

##### Expectation

Container DNS host names should resolve for each other within within the context of a single call to docker-compose up.

##### Initial Result

Neither host_a, nor host_b can see each other, e.g.:

    container_a  | +++ hostname -f
    container_a  | ++ ping -c 1 host_a
    container_a  | PING host_a (172.29.0.3) 56(84) bytes of data.
    container_a  | 64 bytes from host_a (172.29.0.3): icmp_seq=1 ttl=64 time=0.041 ms
    container_a  |
    container_a  | --- host_a ping statistics ---
    container_a  | 1 packets transmitted, 1 received, 0% packet loss, time 0ms
    container_a  | rtt min/avg/max/mdev = 0.041/0.041/0.041/0.000 ms
    container_a  | ++ ping -c 1 host_b
    container_a  | ping: host_b: Name does not resolve
    container_a exited with code 2
