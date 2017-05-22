P_H_error = normalised_distribution_window(1,1)/(normalised_distribution_window(1,1)...
    +normalised_distribution_window(2,1));
P_V_error = normalised_distribution_window(2,3)/(normalised_distribution_window(2,3)...
    +normalised_distribution_window(1,3));
P_L_error = normalised_distribution_window(3,2)/(normalised_distribution_window(3,2)...
    +normalised_distribution_window(4,2));
P_R_error = normalised_distribution_window(4,4)/(normalised_distribution_window(3,4)...
    +normalised_distribution_window(4,4));

P_det_errors = [P_H_error, P_V_error, P_L_error, P_R_error];
figure;bar(P_det_errors);

ch1_dc_per = dark_counts(1)/(distribution_window(1,1)+distribution_window(2,1) +...
    distribution_window(3,1) + distribution_window(4,1));
ch2_dc_per = dark_counts(2)/(distribution_window(1,2)+distribution_window(2,2) +...
    distribution_window(3,2) + distribution_window(4,2));
ch3_dc_per = dark_counts(3)/(distribution_window(1,3)+distribution_window(2,3) +...
    distribution_window(3,3) + distribution_window(4,3));
ch4_dc_per = dark_counts(4)/(distribution_window(1,4)+distribution_window(2,4) +...
    distribution_window(3,4) + distribution_window(4,4));

dc_percentages = [ch1_dc_per, ch2_dc_per, ch3_dc_per, ch4_dc_per];

%%% REMOVE DARK COUNTS %%%%%%%%%%%
%P_det_errors = minus(P_det_errors,dc_percentages);

% Calculate Disturbances
D_Z = (P_det_errors(1) + P_det_errors(2))/2; % Disturbance in HV
D_X = (P_det_errors(3) + P_det_errors(4))/2; % Disturbance in LR

del_x = 2*sqrt(D_Z*(1-D_Z));
del_z = 2*sqrt(D_X*(1-D_X));

D = 0.5*(D_Z + D_X);
%Rate = binary_entropy(D)
Rate = 0.5 * (binary_entropy(0.5 - sqrt(D*(1-D))) - binary_entropy(D))