# Makefile

SPACEX_GRAPHQL_DIR=./Packages/Data/SpaceXGraphQL
APOLLO_DIR=$(SPACEX_GRAPHQL_DIR)/Apollo

# Step 1: Install the Apollo iOS CLI
install-apollo-cli:
	@echo "Installing Apollo iOS CLI..."
	cd $(SPACEX_GRAPHQL_DIR) && swift package --allow-writing-to-package-directory apollo-cli-install

# Step 2: Download the GraphQL schema
fetch-schema:
	@echo "Downloading GraphQL Schema..."
	cd $(SPACEX_GRAPHQL_DIR) && ./apollo-ios-cli fetch-schema --path Apollo/apollo-codegen-config.json

# Step 3: Generate Swift code from GraphQL files
generate:
	@echo "Generating Swift Code from GraphQL files..."
	cd $(SPACEX_GRAPHQL_DIR) && ./apollo-ios-cli generate --path Apollo/apollo-codegen-config.json

# Complete setup process
setup: install-apollo-cli fetch-schema generate
	@echo "Setup complete."

# Helper target for cleaning up
clean:
	@echo "Cleaning up..."
	cd $(SPACEX_GRAPHQL_DIR) && rm -f schema.json API.swift

.PHONY: install-apollo-cli download-schema generate-graphql-code setup clean


