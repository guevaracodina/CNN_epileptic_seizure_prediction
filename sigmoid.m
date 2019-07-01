function y = sigmoid(x)

% Hyperbolic tangent function
%y = (1 - exp(-x)) ./ (1 + exp(-x));

% Logistic Function
y = 1 ./(1 + exp(-x));

end