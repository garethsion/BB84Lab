%%% Calculate Dark Counts %%%%%%%%%%%%%

distribution_sub = distribution_total - distribution_window
%figure;bar(distribution_sub');
%figure;bar(distribution_window');

dark_count_ch1 = (sum(distribution_sub(1,:)))/5.5;
dark_count_ch2 = (sum(distribution_sub(2,:)))/5.5;
dark_count_ch3 = (sum(distribution_sub(3,:)))/5.5;
dark_count_ch4 = (sum(distribution_sub(4,:)))/5.5;
dark_counts = [dark_count_ch1, dark_count_ch2, dark_count_ch3,...
    dark_count_ch4];
figure;
bar(dark_counts);
title('Dark Counts in Each Channel', 'FontSize', 30);
xlabel('Channel (H, V, L, R)', 'FontSize', 28)
ylabel('Dark Counts', 'FontSize', 28);
set(gca, 'FontSize', 24);

%%% Normalise %%%%%%%%%%
norm_dc1 = dark_count_ch1 / (dark_count_ch1 + dark_count_ch2 +... 
    dark_count_ch3 + dark_count_ch4);
norm_dc2 = dark_count_ch2 / (dark_count_ch1 + dark_count_ch2 +... 
    dark_count_ch3 + dark_count_ch4);
norm_dc3 = dark_count_ch3 / (dark_count_ch1 + dark_count_ch2 +... 
    dark_count_ch3 + dark_count_ch4);
norm_dc4 = dark_count_ch4 / (dark_count_ch1 + dark_count_ch2 +... 
    dark_count_ch3 + dark_count_ch4);
normalised_dark_counts = [norm_dc1, norm_dc2, norm_dc3, norm_dc4]
figure;bar(normalised_dark_counts)
