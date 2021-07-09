# Kata data munging

This is a kata for data munging.

### Requirements

* `python3`
* `pip3`
* `gnu make` (optional)

## Usage

To get help run:

```
$ make
```

... which prints out:

```
 help         : provides help
 clean        : removes sentinel files
 clean-hard   : removes sentinel files and venv
 venv         : installs virtual environment
 download-data: downloads data
 prepare-data : prepares data
 jupyter      : launch jupyter notebook
 install      : sets up virtual environment, downloads raw data, and fire jupyter notebook
```

Targets are provided that outline the general pipeline of the Kata:
1. Install virtual environment from requirements.txt
2. Downloads data
3. Prepare data (clean for consumption)
4. Runs the jupyter notebook `notebook.ipynb` in browser



All targets are wired as expected by setting prerequisites (or dependencies) between targets (e.g. running: `$ make prepare-data` will run target: `download-data` as a prerequisite). You can run all steps separately or simply run:

```
$ make install
```

... to run the 4 steps above in one command. This will drop you in a Jupyter notebook, with cleaned data ready to be processed for analysis.
