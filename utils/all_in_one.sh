
#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TASKS=$( find . -maxdepth 1 -mindepth 1 -name \*.sh -a -not -name all_in_one.sh )

# Run all utils bash file into the current folder in order execept this one
for task in $TASKS;
do
    /bin/sh "$SCRIPT_DIR/$task"
done