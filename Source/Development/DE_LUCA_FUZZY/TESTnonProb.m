function tests = TESTnonProb
% AUTHOR: Laura Collins (lac32) 
% LAST MODIFIED: 25/04/16
% Test the Non-Probability entropy function
% http://uk.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests-.html

tests = functiontests(localfunctions);

end


% Test 1 - make sure entropy is less than 1

function testEntropyLessThanOne(testCase)
    testImg = imread('mdb136.pgm');
    assertLessThan(testCase, nonProbabilistic(testImg), 1);
end

% Test 2 - ensure entropy is larger than 0 

function testEntropyLargerThanZero(testCase)
    testImg = imread('mdb136.pgm');
    assertGreaterThan(testCase, nonProbabilistic(testImg), 0);
end