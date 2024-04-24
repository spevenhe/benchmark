import paramiko
import threading
import os
from typing import List, Dict
import statistics
import numpy as np
import sys

import re

def get_vms_ips_zstack_api(script_path: str) -> List[str]:
    # 定义一个空字典来存储输出结果
    output_list = []
    output_set = set()
    # 使用os.popen执行脚本
    with os.popen(script_path) as output:
        for line in output:
            # 将每一行输出添加到列表中
            ip_address = re.search(r'\b(?:\d{1,3}\.){3}\d{1,3}\b', line)
            if ip_address:
                output_set.add(ip_address.group())
            
    output_list = list(output_set)        
    print(output_list)
    return output_list

def get_vms_ips(script_path: str) -> List[str]:
    # 定义一个空字典来存储输出结果
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
    return output_list

def ssh_command(ip, port, user, passwd, command) -> str:
    client = paramiko.SSHClient()
    # 自动接受未知的SSH密钥（不推荐在生产环境中使用）
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, port=port, username=user, password=passwd)
    
    stdin, stdout, stderr = client.exec_command(command)
    result = stdout.read().decode()
    print(result)
    
    client.close()
    return result
    
def thread_function(ip, port, user, passwd, command, results: Dict[str, float]):
    result = ssh_command(ip, port, user, passwd, command)
    try:
        float_value = float(result)
        results[ip] = float_value
    except ValueError:
        print("result format error: can not convert to float")
    
def anlysis_result(results: Dict[str, float]):
    all_values = []
    for values in results.values():
        all_values.append(values)

    # 计算统计值
    mean = statistics.mean(all_values)
    median = statistics.median(all_values)
    percentile_95 = np.percentile(all_values, 95)

    print(f"平均值: {mean}")
    print(f"中位数: {median}")
    print(f"95% 分位数: {percentile_95}")
  
# 主函数的变量需要修改script_path/command/用户/密码等信息，以适应不同的场景
def main():
     # 定义要执行的脚本路径
    script_path = '/home/pdt/benchmark/vm_density/get_zstack_vms.sh'
    output_list = get_vms_ips_zstack_api(script_path)

    # 一个set来储存结果
    result_dict = {}
 
    targets = []
    command = 'start=$(date +%s%3N) && sleep 5 && end=$(date +%s%3N) && echo "$((end - start))"'
    # SSH连接的目标信息
    for result in output_list:
        targets.append((result, 22, "root", "123456", command, result_dict))
        
    threads = []
    for target in targets:
        t = threading.Thread(target=thread_function, args=target)
        t.start()
        threads.append(t)

    for t in threads:
        t.join()

    print("所有SSH命令执行完毕。")
    print(result_dict)
    anlysis_result(result_dict)

if __name__ == "__main__":
    main()
