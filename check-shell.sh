#!/bin/bash

set -e

echo "=== Whirlpool Shell Script Checker ==="
echo

# Check if shellcheck is installed
if ! command -v shellcheck &> /dev/null; then
    echo "Error: shellcheck is not installed"
    echo "Install it with: sudo apt install shellcheck"
    exit 1
fi

# Find all shell scripts to check
SCRIPTS=(
    # Build automation scripts
    auto/build
    auto/config
    auto/clean
    
    # Custom scripts for chroot
    config/includes.chroot/usr/local/sbin/enable-uki
    config/includes.chroot/usr/local/sbin/setup-dracut-uki
)

# Add hook scripts
while IFS= read -r -d '' file; do
    SCRIPTS+=("$file")
done < <(find config/hooks -name "*.hook.chroot" -type f -print0 2>/dev/null || true)

# Add custom .sh files (excluding third-party themes)
while IFS= read -r -d '' file; do
    SCRIPTS+=("$file")
done < <(find config/includes.chroot/usr/local -name "*.sh" -type f -print0 2>/dev/null || true)

ERRORS=0
CHECKED=0

echo "Checking ${#SCRIPTS[@]} shell script(s)..."
echo

for script in "${SCRIPTS[@]}"; do
    if [[ -f "$script" ]]; then
        echo "Checking: $script"
        if shellcheck -x -s sh "$script" 2>&1; then
            echo "  ✓ OK"
        else
            RESULT=$?
            echo "  ✗ FAILED (exit code: $RESULT)"
            ((ERRORS++)) || true
        fi
        ((CHECKED++)) || true
        echo
    fi
done

echo "=== Summary ==="
echo "Scripts checked: $CHECKED"
echo "Errors found: $ERRORS"

if [[ $ERRORS -gt 0 ]]; then
    echo
    echo "Fix the errors above before committing."
    exit 1
fi

echo
echo "All checks passed! ✓"
