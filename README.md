# Prediction of epileptic seizures with convolutional neural networks and functional near-infrared spectroscopy signals
Please cite as:
Rosas-Romero, R., Guevara, E., Peng, K., Nguyen, D. K., Lesage, F., Pouliot, P., & Lima-Saad, W.-E. (2019). _Prediction of epileptic seizures with convolutional neural networks and functional near-infrared spectroscopy signals_ Computers in Biology and Medicine, **111**, 103355. https://doi.org/10.1016/j.compbiomed.2019.103355

## CNN Implementation in MATLAB for epileptic seizure prediction.

## Description
The implementation is designed to solve a binary classification problem. It can be easily modified to solve multi-class problems. The implementation solves epileptic seizure prediction; however, it can be easily modified to solve other applications.

## Main code
```
MAIN_CNN_CODE.m
```

## Comments
The main code calls sub-routines: 
```Data.m ```(Acquisition of observations), ```SAMPLING.m``` (generation of inter-ictal and pre-ictal sets), Crossvalidation.m (generation of sets for training, testing and validation), ```parametersCNN.m``` (layer parameter values have to be defined by user), ```Allocation.m``` (initialization of variables), ```forwardCNN.m``` (forward propagation through convolutional layers), ```backwardCNN1.m``` (backward propagation through the last convolutional layer), ```backwardCNN2.m``` (backward propagation through hidden convolutional layers), ```COST.m``` (Computation of error function by using observations for validation), ```TEST.m``` (Computation of performance metrics by using testing observations).
Sub-routines call from other sub-routines: ```Sigmoid.m, Normalize.m```
