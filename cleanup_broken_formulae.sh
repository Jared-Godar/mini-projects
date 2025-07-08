#!/bin/bash

echo "🔍 Finding formulae with deprecated dependencies..."
DEPRECATED=("openssl@1.1" "pyyaml")
TO_REMOVE=()

for pkg in $(brew missing | awk '{print $1}' | sort -u); do
  for dep in "${DEPRECATED[@]}"; do
    if brew missing | grep -q "$pkg:.*$dep"; then
      TO_REMOVE+=("$pkg")
      break
    fi
  done
done

if [ ${#TO_REMOVE[@]} -eq 0 ]; then
  echo "✅ No formulae depend on deprecated packages."
  exit 0
fi

echo "⚠️ The following formulae depend on deprecated packages:"
printf ' - %s\n' "${TO_REMOVE[@]}"

read -p "❓ Do you want to uninstall these formulae? (y/N): " confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
  for pkg in "${TO_REMOVE[@]}"; do
    echo "📦 Uninstalling $pkg..."
    brew uninstall --ignore-dependencies "$pkg"
  done
  echo "🧹 Running cleanup..."
  brew autoremove
  brew cleanup
else
  echo "🚫 No changes made."
fi
