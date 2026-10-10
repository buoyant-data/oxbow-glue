#!/usr/bin/env bash

# The workspace has a path dependency on the buoyant-oxbow-lambda-shared crate
# from a sibling checkout of the oxbow repository, which must exist before any
# cargo command (even `cargo fmt`) can load the workspace
if [ ! -d ../oxbow ]; then
        git clone --depth 1 https://github.com/buoyant-data/oxbow.git ../oxbow
fi;

if [ -f "${HOME}/.cargo/env" ]; then
        . "${HOME}/.cargo/env"
fi;

which cargo-lambda

if [ $? -ne 0 ]; then
        cargo install cargo-lambda
fi;

which virtualenv

if [ $? -ne 0 ]; then
        echo ">> Virtualenv is required in order to setup cargo-lambda here!"
        exit 1;
fi;

virtualenv venv

source venv/bin/activate
pip install ziglang
