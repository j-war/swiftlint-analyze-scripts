#!/usr/bin/zsh
# ApplySLA.zsh
# Run this script in an xcode buildphase after RunSwiftLintAnalyzer.zsh
# has been run from the cmd line outside of xcode's build phases.

analysislog="analysis.log"

if [ -f $analysislog ]; then # if the file exits, continue
  lines=$(wc -l < $analysislog) &> /dev/null
  if [[ $lines -gt 0 ]]; then
    # If there are lines to apply:
    echo "Lines: $lines"
    while read line; do echo $line; done < $analysislog
    exit 1
  else
    # If there are no lines to apply:
    echo "The $analysislog was empty. There were no errors or warnings detected."
    exit 0
  fi
else
  echo "File not found! Run 'RunSwiftLintAnalyzer.zsh' from the command line first to generate $analysislog"
  exit 1
fi
