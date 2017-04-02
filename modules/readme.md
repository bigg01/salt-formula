```
salt-call pillar.items
local:
    ----------
    default:
        ----------
        scb:
            ----------
            sysctl:
                ----------
                net.ipv4.conf.all.forwarding:
                    1
    fedora-lamp.home:
        ----------
        sysctl:
            ----------
            net.ipv4.conf.all.forwarding:
                1
    test-role:
        ----------
        sysctl:
            ----------
            net.ipv4.conf.all.forwarding:



salt-call pillar.get default:scb:sysctl
            local:
                ----------
                net.ipv4.conf.all.forwarding:
                    1
salt-call pillar.get fedora-lamp.home:sysctl
            local:
                ----------
                net.ipv4.conf.all.forwarding:
                    1
salt-call pillar.get test-role:sysctl
            local:
                ----------
                net.ipv4.conf.all.forwarding:
                    1


```
