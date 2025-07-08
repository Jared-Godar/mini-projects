#!/bin/bash

# ========================================================================
# Cron-Ready Maintenance Script Installer
# Description: Sets up scheduled tasks for system health, cleanup, and backups
# Generated: 2025-05-13 04:46:38
# ========================================================================

# Run system health check and email report every Monday at 7:00 AM
( crontab -l 2>/dev/null; echo "0 7 * * 1 /Users/jaredgodar/bin/system-health.sh" ) | crontab -

# Run Homebrew cleanup and diagnostics every Sunday at 8:00 AM
( crontab -l 2>/dev/null; echo "0 8 * * 0 /opt/homebrew/bin/brew cleanup && /opt/homebrew/bin/brew doctor >> ~/brew-maintenance.log 2>&1" ) | crontab -

# Run disk usage and large file audit monthly on the 1st at 6:30 AM
( crontab -l 2>/dev/null; echo "30 6 1 * * du -sh ~/* | sort -hr | head -n 20 > ~/monthly-disk-usage.log" ) | crontab -

# Backup all Conda environment definitions monthly on the 1st at 7:30 AM
( crontab -l 2>/dev/null; echo "30 7 1 * * conda env export > ~/backups/env-\$(date +\\%F).yml" ) | crontab -

# Report broken symlinks monthly on the 15th at 9:00 AM
( crontab -l 2>/dev/null; echo "0 9 15 * * find ~ -type l ! -exec test -e {} \\; -print > ~/broken-symlinks.log" ) | crontab -
