
%% PARAMETERS OF CONVOLUTIONAL LAYERS

% number of layers (user specified)
L2 = 3;

% number kernels per convolutional layer (user specified)
k2 = [2 2 2];

% dimensions of input data (user specified)
%HD0 = 2 * size(HbO, 1);
%WD0 = 2 * half_window+1;
%DD0 = 1;
HD0 = 146;
WD0 = 125;
DD0 = 2;

% pooling size
rh = 3;
rw = 3;
r = rw;


% dimensinos of output data tensor from convolutional layers
width = WD0;
height = HD0;

% tensor width at the output of each convolutional layer
WD = [WD0];
% tensor height at the output of each convolutional layer
HD = [HD0];
% tensor depth at the output of each convolutional layer
DD = [DD0 k2];

for l = 1 : L2
    width = width /rw;
    height = height / rh;
    
    WD = [WD floor(width)];
    HD = [HD floor(height)];
end

% dimensions of kernels at each convolutional layer (user specified)
% kernel width at each convolutional layer
WK = [3 3 3];
% kernel height at each convolutional layer
HK = WK;
% kernel depth at each convolutional layer
DK = [DD0 k2(1 : L2 - 1)];


%% PARAMETERS OF THE FULLY-CONNECTED LAYERS

% number of features which is the number of inputs to the MLP
% which is the number of output features from convolutional layers
k0 = WD(L2 + 1) * HD(L2 + 1);

% Number of layers
L = 2;

% Number of neurons for each layer
k = [50 1];

% Learning rate
lr = 0.2;

% error tolerance
tolerance = 5;

% Maximum dimension
kmax = max([k0 k]);