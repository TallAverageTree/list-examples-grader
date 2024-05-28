CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point


if [[ -f "student-submission/ListExamples.java" ]]
then 
    cp -r "student-submission/ListExamples.java" "TestListExamples.java" "grading-area/"
    cp -r "lib/" "grading-area/"
    cd "grading-area/"
    javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
    if [[ $? == 0 ]]
    then
        echo "Compiled" 
    else
        echo "Did not compile correctly."
    fi
    java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > "output.txt"
    grep -i "Tests run" output.txt > test_result.txt
    tests_ran=`cat test_result.txt | cut -d " " -f 3 | cut -d "," -f 1`
    tests_failed=`cat test_result.txt | cut -d " " -f 6`
    test_passed=$((tests_ran - tests_failed))
    echo "Test passed: $test_passed, Tests failed: $tests_failed"
    exit
else
    echo "Missing File"
fi
# Then, add here code to compile and run, and do any post-processing of the
# tests
