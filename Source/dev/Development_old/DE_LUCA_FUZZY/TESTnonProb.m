function tests = TESTnonProb
% Test the Membership function
% http://uk.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests-.html

tests = functiontests(localfunctions);

end


% Test 1 - make sure entropy is less than 1

function testNonProbEntropyLessThanOne(testCase)
    testImg = imread('mdb136.pgm');
    assertLessThan(testCase, deLucaFuzzy(testImg), 1);
end

% Test 2 - ensure entropy is larger than 0 

function testNonProbEntropyLargerThanZero(testCase)
    testImg = imread('mdb136.pgm');
    assertGreaterThan(testCase, deLucaFuzzy(testImg), 0);
end