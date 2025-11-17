# Port 7800 Verification Guide

## ✅ Build Completed Successfully

Your app is built and ready in `.output/` directory.

---

## Method 1: Without PM2 (Direct Node.js)

### Start the production server with PORT environment variable:

**Windows (PowerShell):**
```powershell
$env:PORT=7800; $env:NODE_ENV="production"; node .output/server/index.mjs
```

**Windows (CMD):**
```cmd
set PORT=7800 && set NODE_ENV=production && node .output/server/index.mjs
```

### Verify it's running on port 7800:

1. **Check the console output** - Should show:
   ```
   Listening on http://[::]:7800
   ```

2. **Open in browser:**
   ```
   http://localhost:7800
   ```

3. **Test with curl (in another terminal):**
   ```powershell
   curl http://localhost:7800
   ```

### Stop the server:
- Press `Ctrl + C` in the terminal

---

## Method 2: With PM2 (Recommended for Production)

### Start with PM2 using ecosystem config:

```bash
pnpm pm2:start
```

This uses the `ecosystem.config.cjs` file which sets `PORT=7800` automatically.

### Verify it's running on port 7800:

1. **Check PM2 status:**
   ```bash
   pm2 list
   ```
   Should show: `secure-qr-scanner-web` in `online` status

2. **Check PM2 logs (look for port message):**
   ```bash
   pm2 logs secure-qr-scanner-web --lines 20
   ```
   Should show: `Listening on http://[::]:7800`

3. **Test the endpoint:**
   ```bash
   curl http://localhost:7800
   ```

4. **Check which port the process is using:**
   
   **PowerShell:**
   ```powershell
   Get-NetTCPConnection | Where-Object {$_.LocalPort -eq 7800} | Format-Table LocalAddress,LocalPort,State,OwningProcess
   ```
   
   **Or use netstat:**
   ```powershell
   netstat -ano | findstr :7800
   ```
   Should show: `LISTENING` on port 7800

5. **Open in browser:**
   ```
   http://localhost:7800
   ```

### Stop PM2:
```bash
pnpm pm2:stop
```

### Or delete from PM2:
```bash
pnpm pm2:delete
```

---

## Verification Checklist

✅ Build completed without errors  
✅ Port 7800 is free (not used by other apps)  
✅ App starts successfully  
✅ Console shows "Listening on http://[::]:7800"  
✅ Browser opens at http://localhost:7800  
✅ curl returns HTML response  
✅ netstat shows process listening on 7800  

---

## Troubleshooting

### Port 7800 already in use?

**Find what's using it:**
```powershell
Get-Process -Id (Get-NetTCPConnection -LocalPort 7800).OwningProcess
```

**Or with netstat:**
```powershell
netstat -ano | findstr :7800
```

**Kill the process:**
```powershell
taskkill /PID <process_id> /F
```

### PM2 not finding the app?

Make sure you're in the correct directory:
```bash
cd d:\flutter\secure_qr_scanner\website
pnpm pm2:start
```

### Environment variable not working?

PM2 method is more reliable because the PORT is set in `ecosystem.config.cjs`.
The direct node method requires setting the environment variable correctly in your shell.

---

## Quick Test Commands

**Test with PM2:**
```bash
pnpm pm2:start && timeout /t 3 && curl http://localhost:7800
```

**Test without PM2(PowerShell):**
```powershell
$env:PORT=7800; $env:NODE_ENV="production"; Start-Job { node .output/server/index.mjs }; Start-Sleep 3; curl http://localhost:7800; Get-Job | Stop-Job; Get-Job | Remove-Job
```
