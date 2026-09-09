sudo kubeadm reset -f
sudo systemctl stop kubelet
sudo systemctl stop containerd 
sudo rm -rf /etc/kubernetes/
sudo rm -rf /var/lib/kubelet/
sudo rm -rf /var/lib/etcd/
sudo rm -rf /var/lib/dockershim/
sudo rm -rf /var/run/kubernetes/
sudo rm -rf ~/.kube/
sudo rm -rf /etc/cni/net.d/
sudo rm -rf /opt/cni/bin/ 
sudo ip link delete cni0 2>/dev/null
sudo ip link delete flannel.1 2>/dev/null
sudo ip link delete vxlan.calico 2>/dev/null
sudo ip link delete kube-ipvs0 2>/dev/null
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X
sudo ip6tables -F && sudo ip6tables -t nat -F && sudo ip6tables -t mangle -F && sudo ip6tables -X
sudo crictl rm -f $(sudo crictl ps -aq) 2>/dev/null
sudo systemctl restart containerd
mount | grep '/var/lib/kubelet' | awk '{print $3}' | sudo xargs -r umount -l
