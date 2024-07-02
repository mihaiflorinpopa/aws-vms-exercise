#cloud-config
password: ${admin_password}
chpasswd: { expire: False }
ssh_pwauth: True