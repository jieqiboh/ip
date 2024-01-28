#!/usr/bin/env bash

# create bin directory if it doesn't exist
if [ ! -d "../bin" ]
then
    mkdir ../bin
fi

# delete output from previous run
if [ -e "./ACTUAL2.TXT" ]
then
    rm ACTUAL2.TXT
fi

# compile the code into the bin folder, terminates if error occurred
if ! javac -cp ../src/main/java -Xlint:none -d ../bin ../src/main/java/duke/*.java
then
    echo "********** BUILD FAILURE **********"
    exit 1
fi

# run the program, feed commands from input.txt file and redirect the output to the ACTUAL.TXT
java -classpath ../bin Duke < input2.txt > ACTUAL2.TXT

# convert to UNIX format
cp EXPECTED2.TXT EXPECTED-UNIX2.TXT
dos2unix ACTUAL2.TXT EXPECTED-UNIX2.TXT

# compare the output to the expected output
diff ACTUAL2.TXT EXPECTED-UNIX2.TXT
if [ $? -eq 0 ]
then
    echo "Test result: PASSED"
    exit 0
else
    echo "Test result: FAILED"
    exit 1
fi