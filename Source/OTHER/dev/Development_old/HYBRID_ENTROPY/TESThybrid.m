function tests = TESThybrid
% Test the Membership function
% http://uk.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests-.html

tests = functiontests(localfunctions);

end


% Test 1 - make sure entropy is less than 1

function testHybridEntropyLessThanOne(testCase)
    testImg = imread('mdb136.pgm');
    assertLessThan(testCase, hybrid(testImg), 1);
end

% Test 2 - ensure entropy is larger than 0 

function testHybridEntropyLargerThanZero(testCase)
    testImg = imread('mdb136.pgm');
    assertGreaterThan(testCase, hybrid(testImg), 0);
end