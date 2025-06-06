.PHONY: help install test status backup clean verify pull sync diff env env-set cleanup
.PHONY: vscode-export vscode-install vscode-diff brew-export brew-install brew-diff brew-cleanup

SCRIPTS_DIR := scripts

help: ## Show available commands
	@echo 'Dotfiles Management'
	@echo ''
	@echo 'Core:'
	@echo '  install      Install dotfiles and extensions'
	@echo '  status       Show current symlink status'
	@echo '  pull         Export current state to dotfiles'
	@echo '  sync         Pull + commit + push to git'
	@echo '  diff         Show what needs syncing'
	@echo '  env          List environment variables'
	@echo '  env set      Edit environment variables'
	@echo ''
	@echo 'Maintenance:'
	@echo '  test         Run full test suite'
	@echo '  verify       Verify all links are correct'
	@echo '  backup       Create timestamped backup'
	@echo '  clean        Remove symlinks and restore backups'
	@echo '  cleanup      Remove unmanaged packages'

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

pull: ## Export current state to dotfiles
	@$(SCRIPTS_DIR)/sync.sh

sync: ## Pull current state + commit + push to git
	@$(SCRIPTS_DIR)/sync.sh
	@echo "⬆️  Pushing changes..."
	@git add -A
	@if git diff --staged --quiet; then \
		echo "No changes to commit"; \
	else \
		git commit -m "[automated] sync config: $(shell date '+%Y-%m-%d %H:%M')" && \
		git push; \
	fi

diff: ## Show what needs syncing
	@$(SCRIPTS_DIR)/diff.sh

env: ## List environment variables in ~/.env (use 'env set' to edit)
	@$(SCRIPTS_DIR)/env-list.sh

env-set: ## Edit ~/.env file and reload environment variables  
	@$(SCRIPTS_DIR)/env-set.sh

cleanup: ## Remove unmanaged packages
	@$(SCRIPTS_DIR)/cleanup.sh

# Internal tool commands (use 'sync', 'diff', and 'cleanup' instead)
vscode-export:
	@$(SCRIPTS_DIR)/vscode-export.sh

vscode-install:
	@$(SCRIPTS_DIR)/vscode-install.sh

vscode-diff:
	@$(SCRIPTS_DIR)/vscode-diff.sh

brew-export:
	@$(SCRIPTS_DIR)/brew-export.sh

brew-install:
	@$(SCRIPTS_DIR)/brew-install.sh

brew-diff:
	@$(SCRIPTS_DIR)/brew-diff.sh

brew-cleanup:
	@$(SCRIPTS_DIR)/brew-cleanup.sh

# Aliases
uninstall: clean
