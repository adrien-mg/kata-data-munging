SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

VENV = .venv
PYTHON3 = python3.9

RAW_WEATHER_DAT = https://raw.githubusercontent.com/mind-gym/mg-interviews-challenges/master/3-data-munging/weather.dat
RAW_FOOTBALL_DAT = https://raw.githubusercontent.com/mind-gym/mg-interviews-challenges/master/3-data-munging/football.dat

WEATHER_DAT = weather.dat
FOOTBALL_DAT = football.dat

WEATHER_CLEAN = weather.clean
FOOTBALL_CLEAN = football.clean

.PHONY : help clean clean-hard venv jupyter prepare-data install

## help        : provides help
help : Makefile
	@sed -n 's/^##//p' $<

## clean       : removes sentinel files
clean:
	rm -f .sentinel*
	rm -f $(WEATHER_DAT)
	rm -f $(WEATHER_CLEAN)
	rm -f $(FOOTBALL_DAT)
	rm -f $(FOOTBALL_CLEAN)

## clean-hard  : removes sentinel files and venv
clean-hard: clean
	rm -rf $(VENV)

## venv        : installs virtual environment
venv: .sentinel.venv

## jupyter     : launch jupyter notebook
jupyter: venv
	@$(VENV)/bin/jupyter-notebook

## prepare-data: prepare all data
prepare-data: $(FOOTBALL_DAT) $(WEATHER_DAT)
	@./prepare-data.sh $(FOOTBALL_DAT) > $(FOOTBALL_CLEAN)
	./prepare-data.sh $(WEATHER_DAT) > $(WEATHER_CLEAN)

## install     : sets up virtual environment, downloads raw data, and fire jupyter notebook
install: venv prepare-data jupyter

# private targets
$(FOOTBALL_DAT):
	@wget $(RAW_FOOTBALL_DAT) -O $@

$(WEATHER_DAT):
	@wget $(RAW_WEATHER_DAT) -O $@

.sentinel.venv: requirements.txt
	@if [ ! -f $(VENV)/bin/pip ]; then
		$(PYTHON3) -m venv $(VENV)
	fi
	$(VENV)/bin/pip install -U -r requirements.txt
	touch $@

