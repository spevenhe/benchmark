import paramiko
import threading
import os

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

# 定义要执行的脚本路径
script_path = '/home/xinyihe/benchmark/vm_density/get_vms.sh'

# 定义一个空列表来存储输出结果
output_list = []

# 使用os.popen执行脚本
append_flag = False
with os.popen(script_path) as output:
    for line in output:
        # 将每一行输出添加到列表中

        if(append_flag):
            output_list.append(line.strip())
        if("All extracted IP addresses" in line):
            append_flag = True
        

print(output_list)
targets = []
command = 'hostname && date'
# SSH连接的目标信息
for result in output_list:
    targets.append((result, 22, "root", "123456", command))
    
threads = []

for target in targets:
    t = threading.Thread(target=thread_function, args=target)
    t.start()
    threads.append(t)

for t in threads:
    t.join()

print("所有SSH命令执行完毕。")
