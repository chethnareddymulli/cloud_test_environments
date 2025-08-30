import psutil
import time

while True:
    cpu = psutil.cpu_percent(interval=1)
    mem = psutil.virtual_memory().percent
    disk = psutil.disk_usage('/').percent
    print(f"CPU: {cpu}% | Memory: {mem}% | Disk: {disk}%")
    time.sleep(10)
