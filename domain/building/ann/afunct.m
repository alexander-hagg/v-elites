function [value] = afunct(func, x )
%% afunct - Look up for activation functions encoded as ints
% Syntax:  [value] = afunct(func, x )
%
% Inputs:
%    func       - [int]     - activation function ID number
%    x          - [1�N]     - raw output activation 
%
% Outputs:
%    value      - [1�N]     - value of after activation function is applied
%
% See also: express, FFNet
%
% Example: 
%    x = -2:0.01:2;
%    clf; hold on; 
%    for i=1:13; plot(x,afunct(i,x));end
%    legend(' 1-Linear',...
%           ' 2-Unsigned Step',...
%           ' 3-Unsigned Sigmoid',...
%           ' 4-Gaussian', ...
%           ' 5-Signed Sigmoid',...
%           ' 6-Sin',...
%           ' 7-Absolute Value',...
%           ' 8-Square Root',...
%           ' 9-Signed Step',...
%           '10-Squared',...
%           '11-Cosine',...
%           '12-Softplus',...
%           '13-ReLU');
%    grid on; axis([-2 2 -2 2]); title('Activation Functions');

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 06-Mar-2018

%------------- BEGIN CODE --------------

switch func
    case 1 % Linear
        value = x;
    case 2 % Unsigned Step Function
        value = (x>0.5);
    case 3 % Unsigned higher slope sigmoid
        value = (1./(1+exp(-4.9*x)));
    case 4 % Gausian with mean 0 and sigma 1
        value = (exp(-(x-0).^2/(2*1^2)));
    case 5 % Signed higher slope sigmoid
        value = (2./(1+exp(-4.9*x)))-1;
    case 6 % Sin activation
        value = sin(pi*x);
    case 7 % Absolute value
        value = abs(x);
    case 8 % Absolute square root
        value = sqrt(abs(x));        
    case 9 % Signed Step Function
        value = -1+(x>0)*2;
    case 10 % Squared
        value = x.^2;     
    case 11 % Sin activation
        value = cos(pi*x);        
    case 12 % Softplus
        value = log(1+exp(x));
    case 13 % ReLU
        value = max(0,x);        
    case 14 % Ladder
        x = x + abs(min(x(:)));
        x = x./max(x);
        value = discretize(x,[0 0.5 0.99 1.0]) - 1;       
    otherwise
        disp('ERROR in afunct - you did not select a valid activation function. ... Please check the fctPool configuration parameter')
end
%------------- END OF CODE --------------