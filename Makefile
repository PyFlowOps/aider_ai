# NOTE: make help uses a special comment format to group targets.
# If you'd like your target to show up use the following:
#
# my_target: ##@category_name sample description for my_target

default: help

.PHONY: install

install: ##@repo Installs needed prerequisites and software to develop in the SRE space
	$(info ********** Installing Aider AI Prerequisites **********)
	@bash -l scripts/brew.sh
	@brew bundle --force
	@pipx ensurepath
	@bash -l scripts/install.sh -a
	@bash -l scripts/install.sh -p
	@asdf reshim

load: ##@repo Loads the Aider AI application
	$(info ********** Loading Aider AI Models **********)
	@bash scripts/load.sh

list-models: ##@repo Runs the Aider AI application
	$(info ********** List Aider AI Models **********)
	@./dev/.python/bin/python -m uv run aider --list-models groq/
	@./dev/.python/bin/python -m uv run aider --list-models gemini/
	@./dev/.python/bin/python -m uv run aider --list-models gpt/
	@./dev/.python/bin/python -m uv run aider --list-models gpt4all/
	@./dev/.python/bin/python -m uv run aider --list-models llama/
	@./dev/.python/bin/python -m uv run aider --list-models llama2/
	@./dev/.python/bin/python -m uv run aider --list-models openai/
	@./dev/.python/bin/python -m uv run aider --list-models openllm/

llama: ##@run Runs the Aider AI application - Gemini LLM
	$(info ********** Running Llama Aider AI **********)
	@./dev/.python/bin/python -m uv run aider --model ollama/llama3.2 --no-show-model-warnings

gemini: ##@run Runs the Aider AI application - Gemini LLM
	$(info ********** Running Gemini Aider AI **********)
	@bash scripts/gemini.sh

groq: ##@run Runs the Aider AI application - Groq LLM
	$(info ********** Running Groq Aider AI **********)
	@bash scripts/groq.sh

############# Development Section #############
help: ##@misc Show this help.
	@echo $(MAKEFILE_LIST)
	@perl -e '$(HELP_FUNC)' $(MAKEFILE_LIST)

# helper function for printing target annotations
# ripped from https://gist.github.com/prwhite/8168133
HELP_FUNC = \
	%help; \
	while(<>) { \
		if(/^([a-z0-9_-]+):.*\#\#(?:@(\w+))?\s(.*)$$/) { \
			push(@{$$help{$$2}}, [$$1, $$3]); \
		} \
	}; \
	print "usage: make [target]\n\n"; \
	for ( sort keys %help ) { \
		print "$$_:\n"; \
		printf("  %-20s %s\n", $$_->[0], $$_->[1]) for @{$$help{$$_}}; \
		print "\n"; \
	}
