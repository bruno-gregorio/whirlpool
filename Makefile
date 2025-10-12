.PHONY: help build clean rebuild permissions check-shell

.DEFAULT_GOAL := help

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

check-shell: ## Check all shell scripts with shellcheck
	@./check-shell.sh

permissions: ## Set correct permissions on all scripts
	@chmod +x auto/*
	@find config/hooks -type f -name "*.hook.chroot" -exec chmod +x {} \;
	@find config/includes.chroot -type f -path "*/bin/*" -exec chmod +x {} \; 2>/dev/null || true
	@find config/includes.chroot -type f -path "*/sbin/*" -exec chmod +x {} \; 2>/dev/null || true

build: permissions ## Build the Debian 13 Live ISO (requires root)
	@if [ "$$(id -u)" -ne 0 ]; then echo "Error: must run as root (use sudo)"; exit 1; fi
	@lb config
	@lb build 2>&1 | tee build.log

clean: ## Clean build artifacts (requires root)
	@if [ "$$(id -u)" -ne 0 ]; then echo "Error: must run as root (use sudo)"; exit 1; fi
	@lb clean --purge
	@rm -f build.log

rebuild: clean build ## Clean and rebuild from scratch
