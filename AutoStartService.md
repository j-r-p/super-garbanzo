# System Configuration: Auto-Start & SSL Renewal

### 1. Auto-Start Service (Systemd)

**Goal:** Run `/home/ubuntu/super-garbanzo/16/startup.sh` automatically on boot, ensuring the network and Docker are fully ready before execution.

**Step 1: Create the Service File**
Run `sudo nano /etc/systemd/system/super-garbanzo.service` and paste the following configuration:

```ini
[Unit]
Description=Super Garbanzo Startup Script
# "snap.docker.dockerd.service" is required for Docker installed via Snap
After=network.target snap.docker.dockerd.service
Requires=snap.docker.dockerd.service

[Service]
Type=oneshot
User=root
# Adjust path if your script is located elsewhere
ExecStart=/bin/bash /home/ubuntu/super-garbanzo/16/startup.sh
RemainAfterExit=yes
# Safety timeout: If script hangs for >30s, kill it so boot continues
TimeoutStartSec=30

[Install]
WantedBy=multi-user.target

```

**Step 2: Enable the Service**
Run these commands to register the service to run on every reboot:

```bash
sudo chmod +x /home/ubuntu/super-garbanzo/16/startup.sh
sudo systemctl daemon-reload
sudo systemctl enable super-garbanzo.service
#test
sudo systemctl start super-garbanzo.service
sudo systemctl status super-garbanzo.service
```

---

### 2. Cert Refresh 3am (Cron)

**Goal:** Check SSL certificates daily at 3:00 AM. If a certificate is near expiration, renew it and reload Nginx automatically.

**Step 1: Create the Schedule**
Run this command to create a dedicated cron file (safer than editing `crontab -e` manually):

```bash
sudo bash -c 'cat << EOF > /etc/cron.d/certbot-renew
# Run at 3am every day
0 3 * * * root cd /home/ubuntu/super-garbanzo/16/proxy && /snap/bin/docker compose run --rm certbot renew --quiet && /snap/bin/docker compose exec proxy nginx -s reload
EOF'

```

**Step 2: Verify**
You can confirm the file was created correctly by running:

```bash
cat /etc/cron.d/certbot-renew

```
