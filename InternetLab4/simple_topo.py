#!/usr/bin/python3

"""
A simple, custom Mininet topology script for initial setup verification.
Topology: h1 --- s1 --- h2
"""

from mininet.net import Mininet
from mininet.topo import Topo
from mininet.log import setLogLevel
from mininet.cli import CLI 

class SimpleTopo(Topo):
    "Simple topology of two hosts connected to one switch."

    def build(self):
        # 1. Add hosts (virtual end-devices)
        h1 = self.addHost('h1')
        h2 = self.addHost('h2')

        # 2. Add switch (virtual layer-2 device)
        s1 = self.addSwitch('s1')

        # 3. Add links (connections) between the devices
        # Mininet automatically assigns IPs (10.0.0.x) by default.
        self.addLink(h1, s1)
        self.addLink(h2, s1)

if __name__ == '__main__':
    # Set the logging level to 'info' to see important events
    setLogLevel('info')

    # Create the network object using our custom topology
    net = Mininet(topo=SimpleTopo())

    # Start the network, bringing up all interfaces
    net.start()

    print("\n*** Network ready. Use 'h1 ping h2' to test connectivity. ***")
    
    # Drop into the CLI for user interaction
    CLI(net)

    # Stop the network and clean up resources when the user exits the CLI
    net.stop()