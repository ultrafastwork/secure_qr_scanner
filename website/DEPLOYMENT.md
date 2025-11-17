# Production Deployment Guide (CloudPanel v2.x + PM2)

## Port Configuration
- **Production Port:** 7800
- **Dev Port:** 3000 (unchanged)

## Deployment Steps

### 1. Build the Application
```bash
pnpm install
pnpm build
```

### 2. Start with PM2
```bash
pnpm pm2:start
```

This will:
- Start the app on **port 7800**
- Use the production environment
- Enable pm2 cluster mode
- Log errors to `./logs/err.log`
- Log output to `./logs/out.log`

### 3. Verify the App is Running
```bash
pm2 list
pm2 logs secure-qr-scanner-web
```

Check if the app is listening on port 7800:
```bash
curl http://localhost:7800
```

## CloudPanel v2.x Configuration

### Configure Reverse Proxy in CloudPanel

1. **Go to your site in CloudPanel**
2. **Navigate to:** Vhost → Edit Vhost
3. **Add/Update the reverse proxy configuration:**

```nginx
location / {
    proxy_pass http://localhost:7800;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_cache_bypass $http_upgrade;
}
```

4. **Save and reload Nginx:**
```bash
sudo nginx -t
sudo systemctl reload nginx
```

## PM2 Management Commands

```bash
# Start the app
pnpm pm2:start

# Restart after updates
pnpm pm2:restart

# Stop the app
pnpm pm2:stop

# Remove from PM2
pnpm pm2:delete

# View logs
pm2 logs secure-qr-scanner-web

# Monitor
pm2 monit
```

## Auto-Start on Server Reboot

Save PM2 configuration to start automatically:
```bash
pm2 save
pm2 startup
```

Follow the instructions provided by the `pm2 startup` command.

## Troubleshooting

### Port Already in Use
If port 7800 is already in use, check what's using it:
```bash
# Linux
sudo lsof -i :7800
sudo netstat -tulpn | grep 7800

# Or kill the process
sudo kill -9 <PID>
```

### PM2 Not Starting
Check PM2 logs:
```bash
pm2 logs secure-qr-scanner-web --lines 100
```

### Nginx 502 Bad Gateway
1. Verify the app is running: `pm2 list`
2. Check if port 7800 is accessible: `curl http://localhost:7800`
3. Review Nginx error logs: `sudo tail -f /var/log/nginx/error.log`

## Environment Variables

All production environment variables are set in `ecosystem.config.cjs`:
- `NODE_ENV=production`
- `PORT=7800`

To add more variables, edit `ecosystem.config.cjs`:
```javascript
env_production: {
  NODE_ENV: 'production',
  PORT: 7800,
  // Add more here
  YOUR_VAR: 'value'
}
```

## Update Deployment

When you have new changes:
```bash
git pull
pnpm install
pnpm build
pnpm pm2:restart
```
