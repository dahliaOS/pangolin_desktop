.PHONY: all run_unit clean format lint run_web run build

all: lint format build

run_unit: ## Runs unit tests
	@echo "Running flutter test..."
	@flutter test || (echo "Error while running tests"; exit 1)

clean: ## Cleans the environment
	@echo "Cleaning the project..."
	@rm -rf pubspec.lock
	@flutter clean

format:
	@echo "Formatting the code"
	@dart format .

lint:
	@echo "Verifying code..."
	@dart analyze . || (echo "Error in project"; exit 1)

run_web:
ifdef browser
	@echo "Running Pangolin Desktop in $(browser)"
	@flutter run -d $(browser)
else
	@echo "no browser target found"
endif

run:
ifdef target
	@echo "Running Pangolin Desktop"
	@flutter config --enable-$(target)-desktop
	@flutter create .
	@flutter run -d $(target)
else
	@echo "no target found"
endif

build: clean
ifdef target
	@echo "Building Pangolin Desktop for $(target)."
	@flutter config --enable-$(target)-desktop
	@flutter create .
	@flutter build $(target) --release
else
	@echo "no target found"
endif
