# ---- EKS Cluster (Auto Mode) ----
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # Auto Mode — EKS manages node groups, kube-proxy, CoreDNS, etc.
  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose", "system"]
  }

  # Networking
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Security: enable private endpoint, public for initial kubectl access
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # Auth mode required for Auto Mode
  authentication_mode = "API"

  # Security: envelope encryption for secrets at rest
  cluster_encryption_config = {
    resources = ["secrets"]
  }

  # Security: enable logging
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  # Allow current caller (your IAM user/role) to manage the cluster
  enable_cluster_creator_admin_permissions = true
}
