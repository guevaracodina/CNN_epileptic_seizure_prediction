Ln1 = length(INTERICTAL(1, :));
Ln2 = length(PREICTAL(1, :));
Ln3 = length(ICTAL(1, :));

Ln = min([Ln1 Ln2]);

INTERICTAL = INTERICTAL(:, 1:Ln);
PREICTAL = PREICTAL(:, 1:Ln);
ICTAL = ICTAL(:, 1:Ln);


% dimensions of tensor
height = floor(size(ICTAL, 1)/2);
depth = 4 * Ln - width + 1;

DATASET = zeros(height, width, depth);
TARGETS = [];


j = 1;
for i = 1 : width : Ln - width
    DATASET(:, :, j) = INTERICTAL(:, i : i + width - 1, 1 : height);    
    DATASET(:, :, j + 1) = PREICTAL(:, i : i + width - 1);
%    DATASET(:, :, j + 2) = ICTAL(:, i : i + width - 1);
    j = j + 2;
    t = [0 1];
    TARGETS = [TARGETS t];
end;


