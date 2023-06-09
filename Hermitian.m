%Hermite interpolation, 2023
%By Amirmahdi Jafari

 n = input('Enter n for (n+1) nodes, n:  ');
 x = zeros(1,n+1);
 q = zeros(2*n+2,2*n+2);

 for i = 0:n   
   fprintf('Enter x(%d) and f(x(%d)), and f''(x(%d)) on separate lines:  \n', i, i, i);                
   x(i+1) = input(' ');
   q(2*i+1,1) = input(' ');
   q(2*i+2,2) = input(' ');
 end            
 
 z = zeros(1,2*n+2);
 for i = 0:n
    z(2*i+1) = x(i+1);
    z(2*i+2) = x(i+1);
    q(2*i+2,1) = q(2*i+1,1);
    if i ~= 0
       q(2*i+1,2) = (q(2*i+1,1)-q(2*i,1))/(z(2*i+1)-z(2*i));
    end
 end

 k = 2*n+1;
 for i = 2:k
    for j = 2:i
       q(i+1,j+1) = (q(i+1,j)-q(i,j))/(z(i+1)-z(i-j+1));
    end
 end

 fprintf('\nCoefficients of the Hermite polynomial are:\n ');
 for i = 0:k
    fprintf(' %11.8f \n', q(i+1,i+1));
 end

 fprintf('Now enter a point at which to evaluate the polynomial, x = \n');
 xx = input(' ');
 s = q(k+1,k+1)*(xx-z(k));
 for i = 2:k
    j = k-i+1;
    s = (s+q(j+1,j+1))*(xx-z(j));
 end
 s = s + q(1,1);
 fprintf('The interpolated value is:  %11.8f \n\n',s);

 
%This part of code, obtains the symbolic handle form of Hermit function
syms t Q c
 Q = q(1,1);
 c = 1;
 c1 = ones(k+1)
 for l = 2:(k+1)
     if mod(l,2) ==0 
        c1(l) = l/2
     else
        c1(l) = (l+1)/2
     end
 end
 for l=2:(k+1)
        c = c * (t - x(c1(l-1)));
        Q = Q + c*q(l,l)
 end
 dQ = diff(Q);
 pretty(Q)
 pretty(dQ)
 Q = matlabFunction(Q);
 dQ = matlabFunction(dQ);
%  fplot(dQ,[0 13])
%  max = dQ(0);
%  for m = 0:0.01:13
%      if max < dQ(m)
%          max = dQ(m);
%      end
%  end
%  max
 