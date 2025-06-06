.PHONY: install test backup clean status help

DOTFILES_DIR := $(shell pwd)
HOME_DIR := $(HOME)
FILES := .zshrc .gitconfig
VSCODE_DIR := $(HOME_DIR)/Library/Application Support/Code/User
VSCODE_FILES := settings.json

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-12s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install dotfiles by creating symlinks
	@echo "Installing dotfiles..."
	@chmod +x install.sh
	@./install.sh

test: ## Test the installation script
	@echo "Testing dotfiles installation..."
	@echo "Current symlink status:"
	@$(MAKE) status
	@echo "\nTesting backup functionality..."
	@cp ~/.zshrc ~/.zshrc.test-backup 2>/dev/null || true
	@echo "# test file for makefile" > ~/.zshrc.test
	@mv ~/.zshrc.test ~/.zshrc
	@echo "Created test file, running install..."
	@./install.sh
	@echo "Verifying backup was created:"
	@ls -la ~/.zshrc.backup 2>/dev/null && echo "✅ Backup created" || echo "❌ Backup failed"
	@echo "Verifying symlink was created:"
	@ls -la ~/.zshrc | grep "$(DOTFILES_DIR)" && echo "✅ Symlink created" || echo "❌ Symlink failed"
	@rm -f ~/.zshrc.backup ~/.zshrc.test-backup
	@echo "✅ Test completed"

backup: ## Create backup of existing dotfiles
	@echo "Creating backup of existing dotfiles..."
	@mkdir -p backups/$(shell date +%Y%m%d_%H%M%S)
	@for file in $(FILES); do \
		if [ -f "$(HOME_DIR)/$$file" ] && [ ! -L "$(HOME_DIR)/$$file" ]; then \
			echo "Backing up $$file"; \
			cp "$(HOME_DIR)/$$file" "backups/$(shell date +%Y%m%d_%H%M%S)/$$file"; \
		fi; \
	done

status: ## Show current status of dotfiles
	@echo "Dotfiles status:"
	@for file in $(FILES); do \
		printf "$$file: "; \
		if [ -L "$(HOME_DIR)/$$file" ]; then \
			target=$$(readlink "$(HOME_DIR)/$$file"); \
			if [ "$$target" = "$(DOTFILES_DIR)/$$file" ]; then \
				echo "✅ correctly linked"; \
			else \
				echo "⚠️  linked to $$target (not our dotfiles)"; \
			fi; \
		elif [ -f "$(HOME_DIR)/$$file" ]; then \
			echo "📄 regular file (not linked)"; \
		else \
			echo "❌ missing"; \
		fi; \
	done
	@echo "\nVSCode settings:"
	@for file in $(VSCODE_FILES); do \
		printf "$$file: "; \
		vscode_file="$(VSCODE_DIR)/$$file"; \
		if [ -L "$$vscode_file" ]; then \
			target=$$(readlink "$$vscode_file"); \
			if [ "$$target" = "$(DOTFILES_DIR)/vscode/$$file" ]; then \
				echo "✅ correctly linked"; \
			else \
				echo "⚠️  linked to $$target (not our dotfiles)"; \
			fi; \
		elif [ -f "$$vscode_file" ]; then \
			echo "📄 regular file (not linked)"; \
		else \
			echo "❌ missing"; \
		fi; \
	done

clean: ## Remove symlinks and restore from backup if available
	@echo "Cleaning up symlinks..."
	@for file in $(FILES); do \
		if [ -L "$(HOME_DIR)/$$file" ]; then \
			echo "Removing symlink: $$file"; \
			rm "$(HOME_DIR)/$$file"; \
			if [ -f "$(HOME_DIR)/$$file.backup" ]; then \
				echo "Restoring from backup: $$file"; \
				mv "$(HOME_DIR)/$$file.backup" "$(HOME_DIR)/$$file"; \
			fi; \
		fi; \
	done

uninstall: clean ## Alias for clean

verify: ## Verify all dotfiles are properly linked
	@echo "Verifying dotfiles installation..."
	@all_good=true; \
	for file in $(FILES); do \
		if [ ! -L "$(HOME_DIR)/$$file" ] || [ "$$(readlink "$(HOME_DIR)/$$file")" != "$(DOTFILES_DIR)/$$file" ]; then \
			echo "❌ $$file is not properly linked"; \
			all_good=false; \
		fi; \
	done; \
	if $$all_good; then \
		echo "✅ All dotfiles are properly linked"; \
	else \
		echo "❌ Some dotfiles are not properly linked"; \
		exit 1; \
	fi 
