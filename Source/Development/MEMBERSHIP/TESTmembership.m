function tests = membershipTest
% Test the Membership function
% http://uk.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests-.html


tests = functiontests(localfunctions);

end

% Test 1 - test that membership degree array is not empty 
function testMembershipDegree(testCase)  
    testImage = imread('mdb136.pgm');
    memDegree = membership(testImage); 
    verifyNotEmpty(testCase, memDegree);
end