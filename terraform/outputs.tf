output "public_ip" {
  description = "Public IP of the k3s node"
  value       = aws_instance.k3s.public_ip
}

output "ssh_command" {
  description = "SSH into the node"
  value       = "ssh -i <your-key>.pem ubuntu@${aws_instance.k3s.public_ip}"
}

output "kubeconfig_hint" {
  description = "How to fetch the kubeconfig"
  value       = "scp -i <your-key>.pem ubuntu@${aws_instance.k3s.public_ip}:/etc/rancher/k3s/k3s.yaml ./k3s.yaml  # then replace 127.0.0.1 with the public IP"
}
