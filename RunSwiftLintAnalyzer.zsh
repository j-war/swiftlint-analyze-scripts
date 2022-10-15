#!/bin/zsh
# RunSwiftLintAnalyzer.zsh
# Run this separately from normal builds. Do not run in a build phase.
# Then apply the results in a xcode buildphase with ApplySLA.zsh

# Settings
#name="Proj_name"
name=$1
project="$name.xcodeproj"
workspace="$name.xcworkspace"
scheme="$name-sla"
# https://mokacoding.com/blog/xcodebuild-destination-options/
platform="platform=iOS Simulator,name=iPad Pro (11-inch) (3rd generation),OS=16.1" # -destination "platform=iOS Simulator,id=<ID>"
xcodelog="xcodebuild.log"
analysislog="analysis.log"
config=".swiftlint.yml"
echo "Preparing project: $project"

# Clean
directoryToDelete="$HOME/Library/Developer/Xcode/DerivedData/"
moduleCache="ModuleCache.noindex"
# Clear these two log files if there are problems:
# rm $xcodelog
# rm $analysislog
echo "Cleaning workspace"
xcodebuild clean -workspace $workspace -scheme $scheme -destination $platform
# - Use if the xcodebuild clean command is not behaving
# echo "Deleting $directoryToDelete$name-*"
# rm -rf $directoryToDelete$name-* # DANGER
# rm -rf $directoryToDelete$moduleCache # Analysis seems to be fine with not cleaning this folder
echo "Done cleaning"

# Build
echo "Starting build"
xcodebuild -workspace $workspace -scheme $scheme -destination $platform > $xcodelog
echo "Done building"

# Analyze
echo "Starting analysis"
swiftlint analyze --config $config --compiler-log-path $xcodelog > $analysislog
echo "Done analyzing"

exit 1
