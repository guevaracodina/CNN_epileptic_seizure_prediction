


[trainInd,valInd,testInd] = dividerand(N,.8,.1,.1);

length_train = length(trainInd);
train = zeros(height, width, length_train);
targets = zeros(1, length_train);

length_validate = length(valInd);
validate = zeros(height, width, length_validate);
labelv = zeros(1, length_validate);

length_test = length(testInd);
test = zeros(height, width, length_test);
labelt = zeros(1, length_test);


%% GENERATION OF TRAINING OBSERVATIONS
for i=1:length_train
   train(:, :, i) = DATASET(:, :, trainInd(i));
   targets(:, i) = TARGETS( : , trainInd(i));
end

%% GENERATION OF OBSERVATIONS FOR VALIDATION
for i=1:length_validate
   validate(:, :, i) = DATASET(:, :, valInd(i));
   labelv(:, i) = TARGETS( : , valInd(i));
end

%% GENERATION OF TESTING OBSERVATIONS
for i=1:length_test
   test(:, :, i) = DATASET(:, :, testInd(i));
   labelt(:, i) = TARGETS( : , testInd(i));
end