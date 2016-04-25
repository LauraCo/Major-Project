function tests = membershipTest
% Test the Membership function
% http://uk.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests-.html


tests = functiontests(localfunctions);

end

% Test 1 - test that membership degree array is not empty 
function test3TrapeziumMembershipDegreeNotEmpty(testCase)  
    testImage = imread('mdb136.pgm');
    memDegree = membership(testImage); 
    verifyNotEmpty(testCase, memDegree);
end

% Test 2 - test that the size of the membership degree array is the same as
% the image array
function testCalulatedMembershipDegreeForAllPixels3Trapeziums(testCase)
    testImage = imread('mdb136.pgm');
    memDegree = membership(testImage);
    verifySize(testCase, memDegree, size(testImage));
end

% Test 3 - test that Hybrid membership degree array is not empty
function test2TrapeziumMembershipDegreeNotEmpty(testCase)  
    testImage = imread('mdb136.pgm');
    memDegree = hybridMembership(testImage); 
    verifyNotEmpty(testCase, memDegree);
end

% Test 4 - test that the size of the membership degree array is the same as
% the image array
function testCalulatedMembershipDegreeForAllPixels2Trapeziums(testCase)
    testImage = imread('mdb136.pgm');
    memDegree = hybridMembership(testImage);
    verifySize(testCase, memDegree, size(testImage));
end

% Test 5 - test that none of the membership degrees are greater than 1
function test3TrapeziumMembershipDegreeLessThanOne(testCase)
    testImage = imread('mdb136.pgm');
    memDegree = membership(testImage);
    verifyLessThanOrEqual(testCase, memDegree, 1);
end

% Test 6 - test that none of the membership degrees are greater than 1
function test2TrapeziumMembershipDegreeLessThanOne(testCase)
    testImage = imread('mdb136.pgm');
    memDegree = hybridMembership(testImage);
    verifyLessThanOrEqual(testCase, memDegree, 1);
end

% Test 7 - test that none of the membership degrees are less than 0
function test3TrapeziumMembershipDegreeGreaterThanZero(testCase)
    testImage = imread('mdb136.pgm');
    memDegree = membership(testImage);
    verifyGreaterThan(testCase, memDegree, 0);
end

% Test 8 - test that none of the membership degrees are less than 0
function test2TrapeziumMembershipDegreeGreaterThanZero(testCase)
    testImage = imread('mdb136.pgm');
    memDegree = hybridMembership(testImage);
    verifyGreaterThan(testCase, memDegree, 0);
end