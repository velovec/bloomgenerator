#!/usr/bin/env python3

from xmlrpc.client import ServerProxy
server = ServerProxy('http://localhost:9001/RPC2')

print("Do the magic")

server.supervisor.startProcess("bloomgenerator")
