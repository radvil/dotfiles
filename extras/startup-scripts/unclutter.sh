#!/bin/bash

if [ "$XDG_SESSION_TYPE" == "x11" ]; then
  unclutter --timeout=5 &
fi
