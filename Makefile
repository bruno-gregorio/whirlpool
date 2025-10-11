.PHONY: help build clean rebuild

.DEFAULT_GOAL := help

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

build: ## Build the Debian 13 Live ISO (requires root)
	@if [ "$$(id -u)" -ne 0 ]; then echo "Error: must run as root (use sudo)"; exit 1; fi
	@chmod +x auto/* config/hooks/normal/*.hook.chroot 2>/dev/null || true
	@lb config
	@lb build 2>&1 | tee build.log

clean: ## Clean build artifacts (requires root)
	@if [ "$$(id -u)" -ne 0 ]; then echo "Error: must run as root (use sudo)"; exit 1; fi
	@lb clean --purge
	@rm -f build.log

rebuild: clean build ## Clean and rebuild from scratch
