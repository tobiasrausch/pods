#!/bin/bash

# Stop & delete all nodes
multipass stop master
multipass stop node1
multipass stop node2
multipass delete master
multipass delete node1
multipass delete node2
multipass purge
multipass list

