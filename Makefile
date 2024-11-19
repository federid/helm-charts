# ------------------------------
# Project Configuration
# ------------------------------

# Set release directory
RELEASE_DIR := release

# Set charts directory
CHARTS_DIR := charts

# Define federid version
FEDERID_VERSION = 0.1.0
CHART_VERSION = 0.1.0

HELM_CHART_FILE = federid-chart.tgz

# ------------------------------
# Default Target
# ------------------------------
# The default target: clean, build, and test
.PHONY: all
all: helm-package

# ------------------------------
# Clean Targets
# ------------------------------

# Clean target: removes the built webhook binary
.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -rf $(RELEASE_DIR) || true
# ------------------------------
# Helm Targets
# ------------------------------

# Package Helm chart for the federid project
.PHONY: helm-package
helm-package:
	@echo "Packaging Helm Chart"
	# Package the Helm chart located in the charts directory
	cd $(CHARTS_DIR) && helm package federid --version $(CHART_VERSION) --app-version $(FEDERID_VERSION) 
	mkdir $(RELEASE_DIR) || true
	mv $(CHARTS_DIR)/federid-$(CHART_VERSION).tgz $(RELEASE_DIR)
