import paramiko

linux_ip = "your-linux-public-ip"
linux_user = "ubuntu"
key_path = "/path/to/private-key.pem"

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(linux_ip, username=linux_user, key_filename=key_path)

commands = [
    "sudo apt update -y",
    "sudo apt upgrade -y",
    "sudo apt install ufw -y",
    "sudo ufw enable",
]

for cmd in commands:
    stdin, stdout, stderr = ssh.exec_command(cmd)
    print(stdout.read().decode())
ssh.close()
