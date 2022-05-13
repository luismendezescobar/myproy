#!/bin/bash

MY_SHELL=/usr/local/bin/bash
echo ${MY_SHELL}
echo ${MY_SHELL%/*}

echo ${MY_SHELL#*/usr}