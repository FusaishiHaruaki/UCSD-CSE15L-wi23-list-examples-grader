CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
SUBMITTED_FILE='student-submission/ListExamples.java'
DIR='student-submission'

rm -rf student-submission
git clone $1 student-submission
cp TestListExamples.java student-submissoin/
echo 'Finished cloning'

if [[ -f $SUBMITTED_FILE ]]
then echo 'file found'
else 
    echo 'required file does not exist'
    exit
fi

cp TestListExamples.java student-submission
javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar student-submission/*.java
if [[ $? -ne 0 ]]
then
    echo 'compilation failed'
    exit
else echo 'compilation success'
fi

cd student-submission
java -cp .:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples
if [[ $? -ne 0 ]]
then
    echo 'tests compilation failed'
    exit
else echo 'tests compilation success'
fi
java -cp .:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples >results.txt 

grep -q "FAILURES!!!" results.txt
if [[ $? -ne 0 ]]
then echo 'All testcases passed'
else grep "Tests run" results.txt
fi
cd ..
