#!/bin/bash

pdm venv create 3.10
pdm use -f .venv

pdm install -G:all

source .venv/bin/activate
