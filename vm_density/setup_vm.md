dnf install @virt
systemctl start libvirtd
systemctl enable libvirtd
dnf install virt-install virt-manager


use vnc
```
dnf groupinstall "Server with GUI"
systemctl set-default graphical
dnf install tigervnc-server tigervnc-server-module -y

vim /etc/tigervnc/vncserver.users
:1=root

systemctl daemon-reload

vncpasswd
123456

systemctl start vncserver@:1.service
systemctl enable vncserver@:1.service
systemctl status vncserver@:1.service





```
use commandline
```
virt-install \
--name=centos7-vm \
--ram=8192 \
--vcpus=8 \
--disk path=/var/images/centos7-vm.img,size=40 \
--os-type=linux \
--os-variant=centos8 \
--network bridge=virbr0,model=virtio \
--graphics none \
--console pty,target_type=serial \
--location=/var/iso/CentOS-7-x86_64-Minimal-2207-02.iso \
--extra-args='console=ttyS0,115200n8 serial'

qemu-img create -f qcow2 -F qcow2  -b /var/lib/libvirt/images/centos7.0.qcow2 /var/images/centos7.qcow2

virt-clone --original centos7.0 --name centos7.0-2 --file /var/images/centos7.qcow2

virsh domifaddr {}
virsh domblklist {}

``
