1. System Health Monitoring Script: 
To automate the execution of health-monitor.sh script on a Linux system, we can use the cron utility.
steps:

crontab -e
*/10 * * * * /path/to/health-monitor.sh

By setting up this cron job, our script will automatically run at the specified intervals, checking the system health and alerting us if any conditions exceed the predefined thresholds.



2. Automated Backup Solution: 
Run the ./backup.sh script
