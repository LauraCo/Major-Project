function tests = membershipTest
% Test the Membership function
% http://uk.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests-.html
% AUTHOR: Laura Collins (lac32)
% LAST MODIFIED: 07/04/2016


tests = functiontests(localfunctions);

end

% Test 1 - test that 3 fuzzy set membership degree array is not empty 
function test3MembershipDegree(testCase)  
    testImage = imread('mdb136.pgm');
    memDegree = membership(testImage); 
    verifyNotEmpty(testCase, memDegree);
end

% Test 2 -  test that 2 fuzzy set membership degree array is not empty 
function test2MembershipDegree(testCase)  
    testImage = imread('mdb136.pgm');
    memDegree = hybridMembership(testImage); 
    verifyNotEmpty(testCase, memDegree);
end