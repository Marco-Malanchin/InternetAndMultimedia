#!/usr/bin/python3

"""
mesh_topo.py: A Mininet topology with two interconnected switches and four hosts.

Topology:
  h1 -- s1 -- s2 -- h2
   |      |
  h3    h4 (connected via s2)

Specifically:
- h1 and h3 connect to s1
- h2 and h4 connect to s2
- s1 and s2 are connected (the core link)
"""

from mininet.net import Mininet
from mininet.topo import Topo
from mininet.log import setLogLevel
from mininet.cli import CLI 

class MeshTopo(Topo):
    """
    Custom topology class defining 4 hosts, 2 switches,
    and a full set of links to create a basic mesh structure.
    """

    def build(self):
        # 1. Add Hosts (End Devices)
        # We use a dictionary to store host references for easy linking
        hosts = {}
        for i in range(1, 5):
            # Host names will be h1, h2, h3, h4
            host_name = 'h%s' % i
            hosts[host_name] = self.addHost(host_name)

        # 2. Add Switches (Layer-2 devices)
        # Switch names will be s1, s2
        s1 = self.addSwitch('s1')
        s2 = self.addSwitch('s2')

        # 3. Add Links: Host-to-Switch Connections

        # Connect h1 and h3 to switch s1
        self.addLink(hosts['h1'], s1)
        self.addLink(hosts['h3'], s1)
        
        # Connect h2 and h4 to switch s2
        self.addLink(hosts['h2'], s2)
        self.addLink(hosts['h4'], s2)

        # 4. Add Core Link: Switch-to-Switch Connection
        # This link allows all hosts to communicate with each other.
        self.addLink(s1, s2)


if __name__ == '__main__':
    # Set the logging level to 'info' to see network startup details
    setLogLevel('info')

    # Create the network object using our custom topology
    # Mininet automatically starts a default controller (OVSController) for the switches
    net = Mininet(topo=MeshTopo())

    # Start the network, bringing up all virtual interfaces
    net.start()

    print("\n*** Network topology created: h1/h3 <-> s1 <-> s2 <-> h2/h4 ***")
    print("*** Running the CLI. Type 'exit' to stop the network. ***\n")

  # Drop into the CLI for user interaction
    CLI(net)


    # Stop the network and clean up resources when the user exits the CLI
    net.stop()