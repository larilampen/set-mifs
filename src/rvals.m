function v = rvals(min,max,N)
% Return an array of N random values between the given limits.

v=(rand(1,N)*(max-min))+min;
