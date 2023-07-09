PROJECT_NAME=BlipFM
.DEFAULT_GOAL := help
FASTLANE=$(BUNDLE) exec fastlane
BUNDLE=$(if $(rbenv > /dev/null), rbenv exec bundle, bundle)

lint: ## run lint
	$(FASTLANE) lint

test: ## run unit tests
	$(FASTLANE) test

setup: ## install required tools
	brew update
	brew upgrade
	brew cleanup
	brew install rbenv git swiftlint
	rbenv install -s 2.6.4
	rbenv global 2.6.4
	rbenv exec gem install bundler
	make install

install: ## install gems
	$(BUNDLE) install

reset_simulator: ## reset the iPhone simulator
	osascript -e 'tell application "Simulator" to quit'
	xcrun simctl shutdown all
	xcrun simctl erase all

wipe: ## delete all cached outputs, kill and reset all simulators
	rm -rf ~/Library/Developer/Xcode/{DerivedData,Archives,Products}
	osascript -e 'tell application "iOS Simulator" to quit'
	osascript -e 'tell application "Simulator" to quit'
	xcrun simctl erase all

autocorrect_files: ## reformat and autocorrect all swift files in the project
	$(FASTLANE) autocorrect_files

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'