#!/bin/bash
echo "I have a cat." | {
  read LINE
  echo "${LINE}/cat/dog"
} > output.txt



for i in {1..3};do echo "hello there";echo `sleep 1` | bash & PIDS+=($!); done