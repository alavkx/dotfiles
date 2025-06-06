.PHONY: help install test status backup clean verify sync diff
.PHONY: vscode-export vscode-install vscode-diff

SCRIPTS_DIR := scripts

help: ## Show available commands
	@echo 'Dotfiles Management'
	@echo ''
	@echo 'Core:'
	@echo '  install      Install dotfiles and extensions'
	@echo '  status       Show current symlink status'
	@echo '  sync         Export current state to dotfiles'
	@echo '  diff         Show what needs syncing'
	@echo ''
	@echo 'Maintenance:'
	@echo '  test         Run full test suite'
	@echo '  verify       Verify all links are correct'
	@echo '  backup       Create timestamped backup'
	@echo '  clean        Remove symlinks and restore backups'

install: ## Install dotfiles and VSCode extensions
	@chmod +x install.sh && ./install.sh

status: ## Show current symlink status
	@$(SCRIPTS_DIR)/status.sh

test: ## Run full test suite
	@$(SCRIPTS_DIR)/test.sh

backup: ## Create timestamped backup of existing files
	@$(SCRIPTS_DIR)/backup.sh

clean: ## Remove symlinks and restore from backup
	@$(SCRIPTS_DIR)/clean.sh

verify: ## Verify all dotfiles are properly linked
	@$(SCRIPTS_DIR)/verify.sh

sync: ## Export current state to dotfiles
	@$(SCRIPTS_DIR)/sync.sh

diff: ## Show what needs syncing
	@$(SCRIPTS_DIR)/diff.sh

# Internal VSCode commands (use 'sync' and 'diff' instead)
vscode-export:
	@$(SCRIPTS_DIR)/vscode-export.sh

vscode-install:
	@$(SCRIPTS_DIR)/vscode-install.sh

vscode-diff:
	@$(SCRIPTS_DIR)/vscode-diff.sh

# Aliases
uninstall: clean
