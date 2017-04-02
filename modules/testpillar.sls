# default
default:
  scb:
    sysctl:
      net.ipv4.conf.all.forwarding: 1

# role
test-role:
  sysctl:
    net.ipv4.conf.all.forwarding: 1

# minion
fedora-lamp.home:
  sysctl:
    net.ipv4.conf.all.forwarding: 1
