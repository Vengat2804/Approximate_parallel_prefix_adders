function evaluate_error_metrics()
    ks_exact = load("D:/project/simulation/ks_exact_outputs.txt");
    ks_approx = load('D:/project/simulation/ks_approx_outputs.txt');
    lf_exact = load('D:/project/simulation/lf_exact_outputs.txt');
    lf_approx = load('D:/project/simulation/lf_approx_outputs.txt');

    fprintf('--- Kogge-Stone Approximate ---\n');
    calculate_metrics(ks_exact, ks_approx);
    
    fprintf('\n--- Ladner-Fischer Approximate ---\n');
    calculate_metrics(lf_exact, lf_approx);
end

function calculate_metrics(exact, approx)
    if length(exact) ~= length(approx)
        error('Input vectors must be the same length');
    end
    n = 8;
    total_inputs = length(exact);
    max_val = 2^n - 1;

    % Error Distance (ED)
    ED = abs(double(exact) - double(approx));

    % Error Rate (ER)
    ER = sum(ED >4) / length(exact);

    % Mean Error Distance (MED)
    MED = mean(ED);

    % Relative Error Distance (RED)
    RED = sum(ED ./ max(double(exact), 1));  % avoid division by zero

    % Mean Relative Error Distance (MRED)
    MRED = (RED / total_inputs);

    % Normalized Error Distance (NED)
    NED = sum(ED) / ((max_val)^2 * total_inputs);

    fprintf('ER   = %.6f\n', ER);
    fprintf('MED  = %.6f\n', MED);
    fprintf('MRED = %.6f\n', MRED);
    fprintf('NED  = %.6f\n', NED);
end


