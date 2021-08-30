#####
# EFS file system
#####

resource "aws_efs_file_system" "cheqd_node" {
  encrypted = true
  tags = {
    Name = "${var.env}_${var.moniker}_fs"
  }
}

#####
# Mount target
#####

resource "aws_efs_mount_target" "cheqd_node" {
  file_system_id  = aws_efs_file_system.cheqd_node.id
  security_groups = [aws_security_group.cheqd_node_efs.id]
  subnet_id       = aws_subnet.cheqd_node.id
}

#####
# EFS access point
#####

resource "aws_efs_access_point" "cheqd_node" {
  file_system_id = aws_efs_file_system.cheqd_node.id

  posix_user {
    uid = local.container_uid
    gid = local.container_gid
  }

  root_directory {
    path = "/data"

    creation_info {
      owner_uid   = local.container_uid
      owner_gid   = local.container_gid
      permissions = "0755"
    }
  }
}
