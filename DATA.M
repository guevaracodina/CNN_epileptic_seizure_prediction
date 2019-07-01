%% THIS CODE IS USED TO GENERATE TRAINING AND DATA SETS
% This code separates recorded signals into three sets: ictal, pre-ictal
% and inter-ictal. However, ictal observations are discarded for this
% specific application


clear
cd D:\Users\12280\Desktop\RRR\MATLAB\CNN



%% PATIENT 22
load('P122.mat');

Normalize;

N = length(HbO(3, :));
t = 1:N;
i = 50;

%subplot(2, 2, 2)
% interval for ICTAL state
plot(t(15857:17800), HbO(i, 15857:17800), 'g')
hold on
plot(t(39437:41448), HbO(i, 39437:41448), 'g')
plot(t(61509:62811), HbO(i, 61509:62811), 'g')
plot(t(91572:93305), HbO(i, 91572:93305), 'g')
ICTAL1 = [HbO(:, 15857:17800); HbR(:, 15857:17800)];
ICTAL2 = [HbO(:, 39437:41448); HbR(:, 39437:41448)];
ICTAL3 = [HbO(:, 61509:62811); HbR(:, 61509:62811)];
ICTAL4 = [HbO(:, 91572:93305); HbR(:, 91572:93305)];
ICTAL = [ICTAL1 ICTAL2 ICTAL3 ICTAL4];

% interval for PREICTAL state
plot(t(10157:15856), HbO(i, 10157:15856), 'r')
plot(t(33737:39436), HbO(i, 33737:39436), 'r')
plot(t(55809:61508), HbO(i, 55809:61508), 'r')
plot(t(85872:91571), HbO(i, 85872:91571), 'r')

for i = 10157:15857
    PREICTAL1 = [HbO(:, i); HbR(:, i)];
end

for i = 33737:39436
    PREICTAL2 = [HbO(:, i); HbR(:, i)];
end

for i = 55809:61508
    PREICTAL3 = [HbO(:, i); HbR(:, i)];
end

for i = 85872:91571
    PREICTAL4 = [HbO(:, i); HbR(:, i)];
end
PREICTAL = [PREICTAL1 PREICTAL2 PREICTAL3 PREICTAL4];

% detecting beginning of INTERICTAL state

plot(t(1:10156), HbO(i, 1:10156), 'b');
plot(t(17801:33737), HbO(i, 17801:33737), 'b');
plot(t(41449:55809), HbO(i, 41449:55809), 'b');
plot(t(62812:85872), HbO(i, 62812:85872), 'b');
plot(t(93306:N), HbO(i, 93306:N), 'b');

for i = 1:10156
    INTERICTAL1 = [HbO(:, i); HbR(:, i)];
end
for i = 17801:33737
    INTERICTAL2 = [HbO(:, i); HbR(:, i)];
end
for i = 41449:55809
    INTERICTAL3 = [HbO(:, i); HbR(:, i)];
end
for i = 62812:85872
    INTERICTAL4 = [HbO(:, i); HbR(:, i)];
end
for i = 93306:N
    INTERICTAL5 = [HbO(:, 93306:N); HbR(:, 93306:N)];
end
INTERICTAL = [INTERICTAL1 INTERICTAL2 INTERICTAL3 INTERICTAL4 INTERICTAL5];



xlabel('time'); ylabel('amplitude'); title('Patient 22');

% labels for class 1 - interictal
class1 = [ones(1,10156) zeros(1,7644) ones(1,15937) zeros(1,7711) ones(1,14361) zeros(1,7002) ones(1,23061) zeros(1,7433) ones(1, 2865)];
figure(2)
subplot(3, 1, 1)
plot(class1, 'b')

% labels for class 2 - preictal
class2 = [zeros(1,10156) ones(1,5700) zeros(1,17880) ones(1,5700) zeros(1,16372) ones(1,5700) zeros(1,24363) ones(1,5700) zeros(1,4600)];
subplot(3, 1, 2)
plot(class2, 'r')

% labels for class 3 - ictal
class3 = [zeros(1,15856) ones(1,1944) zeros(1,21636) ones(1,2012) zeros(1,20060) ones(1,1303) zeros(1,28760) ones(1,1734) zeros(1, 2865)];
subplot(3, 1, 3)
plot(class3, 'g')



