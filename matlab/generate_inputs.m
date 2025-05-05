num_samples = 10000;
A = randi([0, 255], num_samples, 1); 
B = randi([0, 255], num_samples, 1);
input_vectors = [A, B];
fileID = fopen('input_vectors.txt', 'w');
for i = 1:num_samples
    fprintf(fileID, '%d %d\n', input_vectors(i, 1), input_vectors(i, 2));
end
fclose(fileID);