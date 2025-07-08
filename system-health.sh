#!/bin/bash

EMAIL="jared.godar@gmail.com"
LOG_FILE=~/system-health.log
ERROR_LOG=~/system-health-errors.log
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
SUBJECT="System Health Report - $TIMESTAMP"

echo "🧠 System Health Check - $TIMESTAMP" | tee "$LOG_FILE"
echo "----------------------------------------" | tee -a "$LOG_FILE"

echo -e "\n🔍 Homebrew Doctor:" | tee -a "$LOG_FILE"
/opt/homebrew/bin/brew doctor 2>&1 | tee -a "$LOG_FILE"

echo -e "\n🔄 Homebrew Updates:" | tee -a "$LOG_FILE"
/opt/homebrew/bin/brew update >> "$LOG_FILE" 2>&1
/opt/homebrew/bin/brew upgrade >> "$LOG_FILE" 2>&1
/opt/homebrew/bin/brew cleanup >> "$LOG_FILE" 2>&1

echo -e "\n🔍 Outdated Brew Packages:" | tee -a "$LOG_FILE"
/opt/homebrew/bin/brew outdated | tee -a "$LOG_FILE"

echo -e "\n🔍 Conda Doctor:" | tee -a "$LOG_FILE"
/opt/homebrew/bin/conda doctor 2>&1 | tee -a "$LOG_FILE"

# Source the correct Conda base
source "$(/opt/homebrew/bin/conda info --base)/etc/profile.d/conda.sh"
conda activate base

echo -e "\n🔄 Conda Updates (base environment):" | tee -a "$LOG_FILE"
conda update -n base --all -y >> "$LOG_FILE" 2>&1
conda clean --all -y >> "$LOG_FILE" 2>&1

echo -e "\n🔍 Outdated Pip Packages:" | tee -a "$LOG_FILE"
pip list --outdated | tee -a "$LOG_FILE"

echo -e "\n🔄 Updating Pip Packages:" | tee -a "$LOG_FILE"
pip list --outdated --format=json | python3 -c "import sys, json; print(' '.join(p['name'] for p in json.load(sys.stdin)))" | xargs -n1 pip install -U >> "$LOG_FILE" 2>&1

echo -e "\n✅ Health check complete: $TIMESTAMP" | tee -a "$LOG_FILE"
echo "----------------------------------------" | tee -a "$LOG_FILE"

# Email the log via msmtp
if grep -qi "error\|fail\|missing\|altered" "$LOG_FILE"; then
  cp "$LOG_FILE" "$ERROR_LOG"
  {
    echo "Subject: $SUBJECT [❌ Issues Detected]"
    echo "From: $EMAIL"
    echo "To: $EMAIL"
    echo ""
    echo "⚠️ Issues detected during system health check on $TIMESTAMP"
    echo "See full log below:"
    echo ""
    cat "$ERROR_LOG"
  } | msmtp "$EMAIL"
else
  {
    echo "Subject: $SUBJECT [✅ Clean]"
    echo "From: $EMAIL"
    echo "To: $EMAIL"
    echo ""
    echo "✅ All systems operational on $TIMESTAMP"
    echo "See full log below:"
    echo ""
    cat "$LOG_FILE"
  } | msmtp "$EMAIL"
fi
