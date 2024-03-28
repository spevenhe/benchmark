dnf install @virt
systemctl start libvirtd
systemctl enable libvirtd
dnf install virt-install


virt-install \
--name=centos7-vm \
--ram=8192 \
--vcpus=8 \
--disk path=/var/images/centos7-vm.img,size=40 \
--os-type=linux \
--os-variant=centos8 \
--network bridge=virbr0 \
--graphics none \
--console pty,target_type=serial \
--location=//var/iso/CentOS-7-x86_64-Minimal-2207-02.iso \
--extra-args='console=ttyS0,115200n8 serial'
