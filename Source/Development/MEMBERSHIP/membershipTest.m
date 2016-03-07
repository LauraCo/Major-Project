function tests = membershipTest
% Test the Membership function
% http://uk.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests-.html


tests = functiontests(localfunctions);

end

function testMembershipDegree(testCase)  
    testImage = imread('../test.jpeg');
    memDegree = membership(testImage); 
    verifyNotEmpty(testCase, memDegree);
end