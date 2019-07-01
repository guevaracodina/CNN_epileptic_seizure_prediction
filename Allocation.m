%% ALLOCATING SPACE FOR VARIABLES FOR FULLY-CONNECTED LAYERS

% Initializing synaptic weights in fully connected layers
W = rand([kmax, kmax+1, L]) - 0.5;
W2 = zeros (kmax,kmax+1,L);
DW = zeros (kmax,kmax+1,L);

% Initializing outputs for each fully-connected layer
Y = zeros(kmax, L);
V = zeros(kmax, L);
D = zeros(kmax, L);


%% ALLOCATING SPACE FOR VARIABLES FOR CONVOLUTIONAL LAYERS

% input data tensor
Y0 = zeros(WD0, HD0, DD0);

% data tensors after convolutions
Vijlp = zeros(max(WD), max(HD), L2, max(DD));

% local gradients at each convolutional layer 
Gijlp = zeros(max(WD), max(HD), L2, max(DD));

% data tensors after activation function
Zijlp = zeros(max(WD), max(HD), L2, max(DD));

% data tensors after pooling
Yablp = zeros(max(WD), max(HD), L2, max(DD));

% kernels
Wmnklp = zeros(max(WK), max(HK), max(DK), L2, max(DD));

% bias
blp = zeros(L2, max(DD));
