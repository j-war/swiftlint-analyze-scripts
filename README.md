# swiftlint-analyze-scripts

SwiftLint Analyzer scripts for Xcode


## Setup:

Add your project to a new workspace and in that workspace:
1. Go to your project file and in targets, duplicate your current target by right clicking it and selecting 'Duplicate'. This will create a new scheme as well.
2. Rename and append "-sla" to the new target and scheme.
3. Go to build phases of the new target and remove unneeded scripts (You don't need another swiftlint entry for example)
4. Go to build phases of your regular target and add a new script near the end and copy the contents of ApplySLA.zsh (uncheck based on dep.)
5. Place RunSwiftLintAnalyzer.zsh beside your .xcodeproj and .xcworkspace files.

## To run:
1. From the command line enter 'zsh RunSwiftLintAnalyzer.zsh NameOfMyProj' or make it executable, after the above has been completed.
 - Please read the script as you can customize some details like platform/destination. 
   - See https://mokacoding.com/blog/xcodebuild-destination-options/ for examples
 - or you can delete the platform/destination variable entirely
2. After it completes you should have an **analysis.log** file beside your .xcodeproj and .xcworkspace files.
3. Run a regular build, cmd+b, now you can view the results of the swiftlint analyzer in Xcode. You should see the analyzer warnings and errors on lines just like the linting rules.


PS - I wouldn't run RunSwiftLintAnalyzer.zsh on every build but instead check it every once in awhile.


## Troubleshooting:
- If RunSwiftLintAnalyzer.zsh is having problems then try uncommenting some of the 'rm rf' commands but be careful. Or manually delete DerivedData/clean cache
- **Don't** try to run RunSwiftLintAnalyzer.zsh within a Build Phase in Xcode, it won't work and has to be run from a command line
- If line numbers are incorrent or warnings/errors are staying - you will need to update the **analysis.log** file by rerunning RunSwiftLintAnalyzer.zsh
