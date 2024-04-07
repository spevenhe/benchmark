#!/bin/bash

# 执行virsh list --all命令，并筛选出状态为running的虚拟机
virsh list --all | grep running | awk '{print $2}'
