#!/usr/bin/python

"""
Mininet Topology Script for Internet Lab Exercise
Topology: h1 --- r1 --- r2 --- h2

- Routers (r1, r2) are configured as real Linux routers using the Router class.
- Hosts (h1, h2) are simple Mininet hosts.
- NO IP addresses or routing rules are configured here; students must do this manually.
"""

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.log import setLogLevel, info
from mininet.node import Node
from mininet.cli import CLI
from mininet.util import quietRun

class LinuxRouter(Node):
    """A Node with IP forwarding enabled, acting as a router."""

    def config(self, **params):
        super(LinuxRouter, self).config(**params)
        # Enable IP forwarding
        self.cmd('sysctl net.ipv4.ip_forward=1')

    def terminate(self):
        # Disable IP forwarding on exit
        self.cmd('sysctl net.ipv4.ip_forward=0')
        super(LinuxRouter, self).terminate()

class CustomRouterTopo(Topo):
    """
    Custom topology:
    h1 -- r1 -- r2 -- h2
    """
    def build(self, **_opts):
        # Add routers (LinuxRouter) and hosts (default Host)
        r1 = self.addHost('r1', cls=LinuxRouter)
        r2 = self.addHost('r2', cls=LinuxRouter)
        h1 = self.addHost('h1')
        h2 = self.addHost('h2')

        # Add links:
        # Note: In Mininet, interfaces are named automatically:
        # r1-eth0 (to h1)
        # r1-eth1 (to r2)
        # r2-eth0 (to r1)
        # r2-eth1 (to h2)

        # LAN-A Link (h1 <-> r1)
        self.addLink(h1, r1, bw=10) 

        # WAN-Link (r1 <-> r2)
        self.addLink(r1, r2, bw=1) # Low bandwidth for WAN simulation

        # LAN-B Link (r2 <-> h2)
        self.addLink(r2, h2, bw=10)

def run_lab():
    "Instantiate the topology and start the Mininet CLI."
    topo = CustomRouterTopo()
    net = Mininet(topo=topo)
    net.start()

    info("************************************************************************\n")
    info("*** Starting Mininet Internet Lab Exercise ***\n")
    info("*** The topology is running, but no IP addresses or routes are set. ***\n")
    info("*** Consult mininet_lab_exercise.md for instructions. ***\n")
    info("************************************************************************\n\n")
    
    # Dump initial configuration (interfaces exist, but IPs are unconfigured)
    info(net.hosts[0].cmd('ip addr'))

    CLI(net)
    net.stop()

if __name__ == '__main__':
    # Set the logging level to avoid excessive output
    setLogLevel('info')
    # Run the main function
    run_lab()