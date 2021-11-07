#!/bin/sh
capture_info=$(amixer get 'Capture' | grep Capture)
if [[ $capture_info == *"[off]"* ]]; then
  echo "📴"
else
  echo "🎤"
fi
