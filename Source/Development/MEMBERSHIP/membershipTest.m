function tests = membershipTest
% Test the Membership function
% http://uk.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests-.html

tests = functiontests(localfunctions);

end

function testMembershipDegree(testCase)
    actMemDegree = membership('test.jpeg',80,230); % Pass in the image, and the coordinate to check membership degree of
    expMemDegree = 0.644444444444444; % From previous SPIKE work, this is the known membership degree
    testCase.verifyEqual(actMemDegree,double(expMemDegree), 'RelTol', 0.0001);
end