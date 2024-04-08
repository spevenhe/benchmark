#!/bin/bash

# 执行virsh list --all命令，并筛选出状态为running的虚拟机
output=$(virsh list --all | grep running | awk '{print $2}')
echo $output
# 使用readarray命令将输出转换为数组
readarray -t vms <<< "$output"
echo $vms
# 定义一个新数组来存储IP地址
ip_addresses=()
# 遍历数组中的每个虚拟机名称
for vm in "${vms[@]}"; do
  echo "Processing $vm..."
  # 使用virsh domifaddr命令获取指定虚拟机的网络接口信息
  output=$(virsh domifaddr "$vm")

  # 使用grep过滤出含有ipv4地址的行，然后用awk提取IP地址部分
  ip_address=$(echo "$output" | grep 'ipv4' | awk '{print $4}' | cut -d'/' -f1)

  # 检查IP地址是否为空
  if [ -z "$ip_address" ]; then
    # IP地址为空，打印错误日志
    echo "Error: No IP address extracted for $vm."
  else
    # IP地址不为空，添加到数组中
    ip_addresses+=("$ip_address")
    # 打印提取出的IP地址
    echo "Extracted IP Address for $vm: $ip_address"
  fi
  echo "-----------------------------------"
done

echo "All extracted IP addresses:"
for ip in "${ip_addresses[@]}"; do
  echo "$ip"
done