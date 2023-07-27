% =================================================
%       Foad Moslem (foad.moslem@gmail.com) - Researcher | Aerodynamics
%       Using MATLAB R2022a
% =================================================
clc
clear
close all

% =================================================
tic
global numFunc
numFunc = 0;

% Curve Plotting ======================================
a = 0;
b = 4;
NumOfNodes = 200;
x = linspace(a,b,NumOfNodes);
y = ObjFun(x);
plot(x,y)
hold on

% Main Code - Quadratic ===============================
delta = 0.1;
epsilon = 1e-6;
xA = 0;
fxA = ObjFun(xA);
x1 = xA + delta;
fx1 = ObjFun(x1);

if fx1 > fxA
    xC = x1;
    fxC = fx1;
    xB = xA + delta/2;
    fxB = ObjFun(xB);
else
    x2 = x1 + delta;
    fx2 = ObjFun(x2);
    while fx2 <= fx1
        delta = 2*delta;
        x1 = x2;
        fx1 = fx2;
        x2 = x1 + delta;
        fx2 = ObjFun(x2);
    end
    xB = x1;
    fxB = fx1;
    xC = x2;
    fxC = fx2;
end

s = (xA - xB)*(xB - xC)*(xC - xA);
a = (fxA*xB*xC*(xC - xB) + fxB*xC*xA*(xA - xC) + fxC*xA*xB*(xB - xA))/s;
b = (fxA*(xB^2 - xC^2) + fxB*(xC^2 - xA^2) + fxC*(xA^2 - xB^2))/s;
c = (-1) * (fxA*(xB - xC) + fxB*(xC - xA) + fxC*(xA - xB))/s;
lambda = ((-1)*b)/(2*c);
hlambda = a + (b*lambda) + (c*lambda^2);
flambda = ObjFun(lambda);
l = abs((hlambda - flambda)/flambda);

while l > epsilon
    if lambda > xB && flambda < fxB
        xA = xB;
        fxA = fxB;
        xB = lambda;
        fxB = flambda;
    elseif lambda > xB && flambda > fxB
        xC = lambda;
        fxC = flambda;
    elseif lambda < xB && flambda < fxB
        xC = xB;
        fxC = fxB;
        xB = lambda;
        fxB = flambda;
    elseif lambda < xB && flambda > fxB
        xA = lambda;
        fxA = flambda;
    end
    s = (xA - xB)*(xB - xC)*(xC - xA);
    a = (fxA*xB*xC*(xC - xB) + fxB*xC*xA*(xA - xC) + fxC*xA*xB*(xB - xA))/s;
    b = (fxA*(xB^2 - xC^2) + fxB*(xC^2 - xA^2) + fxC*(xA^2 - xB^2))/s;
    c = (-1) * (fxA*(xB - xC) + fxB*(xC - xA) + fxC*(xA - xB))/s;
    lambda = ((-1)*b)/(2*c);
    hlambda = a + (b*lambda) + (c*lambda^2);
    flambda = ObjFun(lambda);
    l = abs((hlambda - flambda)/flambda);
end
% =================================================
fprintf('Number of CallFunction: %6.f\n',numFunc)
fprintf('CPU time: %6.4f\n',toc)
fprintf('X Value of Optimum Point: %6.4f\n',lambda)
fprintf('Y Value of Optimum Point: %6.4f\n',flambda)
plot(lambda,flambda,'kx')