#!/bin/sh
capture_info=$(amixer get 'Capture' | grep Capture)
[[ "$capture_info" == *"[off]"* ]] && echo "📴" || echo "🎤"
