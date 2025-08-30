import os
import paramiko
import requests

servers = {
    "Linux": "your-linux-public-ip",
    "Windows": "your-windows-public-ip"
}

def ping_server(ip):
    response = os.system(f"ping -c 2 {ip}")
    return response == 0

for name, ip in servers.items():
    status = "Online" if ping_server(ip) else "Offline"
    print(f"{name} server ({ip}) is {status}")
