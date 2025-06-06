.PHONY: help install test status backup clean verify
.PHONY: vscode-export vscode-install vscode-diff

SCRIPTS_DIR := scripts

help: ## Show available commands
	@echo 'Dotfiles Management'
	@echo ''
	@echo 'Core:'
	@echo '  install      Install dotfiles and VSCode extensions'
	@echo '  status       Show current symlink status'
	@echo '  test         Run full test suite'
	@echo '  verify       Verify all links are correct'
	@echo ''
	@echo 'Maintenance:'
	@echo '  backup       Create timestamped backup'
	@echo '  clean        Remove symlinks and restore backups'
	@echo ''
	@echo 'VSCode:'
	@echo '  vscode-export    Export current extensions'
	@echo '  vscode-install   Install extensions from list'
	@echo '  vscode-diff      Compare installed vs dotfiles'

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

vscode-export: ## Export current VSCode extensions
	@$(SCRIPTS_DIR)/vscode-export.sh

vscode-install: ## Install VSCode extensions from dotfiles
	@$(SCRIPTS_DIR)/vscode-install.sh

vscode-diff: ## Compare installed vs dotfiles extensions
	@$(SCRIPTS_DIR)/vscode-diff.sh

# Aliases
uninstall: clean
