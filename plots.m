%%% ADD UP ALL PHOTON EVENTS IN SPECIFIC SECTIONS OF PULSE (SELECTING TIMING WINDOW) %%%%%%%%%%%%%%%%%%%
[Nmax,imax1] = max(h1_0);
[Nmax,imax2] = max(h2_0);
[Nmax,imax3] = max(h3_0);
[Nmax,imax4] = max(h4_0);
width = 15;
sum0_window = [sum(h1_0(imax1-width:imax1+width)),sum(h2_0(imax2-width:imax2+width)),sum(h3_0(imax3-width:imax3+width)),sum(h4_0(imax4-width:imax4+width))];
sum1_window = [sum(h1_1(imax1-width:imax1+width)),sum(h2_1(imax2-width:imax2+width)),sum(h3_1(imax3-width:imax3+width)),sum(h4_1(imax4-width:imax4+width))];
sum2_window = [sum(h1_2(imax1-width:imax1+width)),sum(h2_2(imax2-width:imax2+width)),sum(h3_2(imax3-width:imax3+width)),sum(h4_2(imax4-width:imax4+width))];
sum3_window = [sum(h1_3(imax1-width:imax1+width)),sum(h2_3(imax2-width:imax2+width)),sum(h3_3(imax3-width:imax3+width)),sum(h4_3(imax4-width:imax4+width))];
distribution_window = [sum0_window',sum1_window',sum2_window',sum3_window'];
figure;bar(distribution_window');
title(sprintf('PHOTON EVENTS IN WINDOWED PULSE SECTIONS:\n H (dark blue),V (light blue), L (green), R (yellow)', 'FontSize', 30));
xlabel('Pulse level','FontSize', 28);
ylabel('Total counts in timing window', 'FontSize', 28);
set(gca,'fontsize',24)