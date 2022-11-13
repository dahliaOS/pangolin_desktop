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
        @echo "Running Pangolin Desktop in Chrome"
        @flutter run -d chrome
 
run:
        @echo "Running Pangolin Desktop"
        @flutter config --enable-linux-desktop
        @flutter create .
        @flutter run -d linux
 
build: clean 
        @echo "Building Pangolin Desktop for Linux"
        @flutter config --enable-linux-desktop
        @flutter create .
        @flutter build linux --debug
