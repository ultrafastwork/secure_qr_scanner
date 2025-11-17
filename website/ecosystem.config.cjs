module.exports = {
  apps: [{
    name: 'secure-qr-scanner-web',
    script: 'node_modules/.bin/vinxi',
    args: 'start',
    instances: 1,
    exec_mode: 'cluster',
    env_production: {
      NODE_ENV: 'production',
      PORT: 7800
    },
    error_file: './logs/err.log',
    out_file: './logs/out.log',
    log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
    combine_logs: true,
    time: true
  }]
};
