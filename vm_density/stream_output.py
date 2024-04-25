import paramiko
import time

# 初始化SSH客户端
client = paramiko.SSHClient()
# 自动接受未知的SSH密钥（注意：不推荐在生产环境中使用）
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# 连接到SSH服务器
client.connect(ip, port=port, username=user, password=passwd)

# 执行命令
stdin, stdout, stderr = client.exec_command(command)

# 打开一个文件用于存储输出
with open('output.txt', 'w') as f:
    # 循环读取stdout输出
    while not stdout.channel.exit_status_ready():
        # 检查是否有输出可读
        if stdout.channel.recv_ready():
            # 读取输出
            output = stdout.channel.recv(1024).decode()
            # 将输出写入文件
            f.write(output)
            # 也可以在这里打印输出
            print(output)
        # 等待一小段时间再次检查，避免CPU占用过高
        time.sleep(0.1)

# 关闭SSH连接
client.close()