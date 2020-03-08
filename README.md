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

##### Eventual Result

Docker's automatic DNS works with container names, not hostnames.

    container_a  | ++ ping -c 1 container_a
    container_a  | PING container_a (192.168.48.2) 56(84) bytes of data.
    container_a  | 64 bytes from host_a (192.168.48.2): icmp_seq=1 ttl=64 time=0.052 ms
    container_a  |
    container_a  | --- container_a ping statistics ---
    container_a  | 1 packets transmitted, 1 received, 0% packet loss, time 0ms
    container_a  | rtt min/avg/max/mdev = 0.052/0.052/0.052/0.000 ms
    container_a  | ++ ping -c 1 container_b
    container_a  | PING container_b (192.168.48.3) 56(84) bytes of data.
    container_a  | 64 bytes from container_b.docker-compose-dns-test_default (192.168.48.3): icmp_seq=1 ttl=64 time=0.103 ms
    container_a  |
    container_a  | --- container_b ping statistics ---
    container_a  | 1 packets transmitted, 1 received, 0% packet loss, time 0ms
    container_a  | rtt min/avg/max/mdev = 0.103/0.103/0.103/0.000 ms
