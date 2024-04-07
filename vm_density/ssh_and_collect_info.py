import paramiko
import threading

def ssh_command(ip, port, user, passwd, command):
    client = paramiko.SSHClient()
    # 自动接受未知的SSH密钥（不推荐在生产环境中使用）
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, port=port, username=user, password=passwd)
    
    stdin, stdout, stderr = client.exec_command(command)
    print(stdout.read().decode())
    
    client.close()

def thread_function(ip, port, user, passwd, command):
    ssh_command(ip, port, user, passwd, command)

# SSH连接的目标信息
targets = [
    ("192.168.1.1", 22, "user1", "password1", "ls"),
    ("192.168.1.2", 22, "user2", "password2", "ls"),
    # 添加更多机器的信息...
]

threads = []

for target in targets:
    t = threading.Thread(target=thread_function, args=target)
    t.start()
    threads.append(t)

for t in threads:
    t.join()

print("所有SSH命令执行完毕。")
