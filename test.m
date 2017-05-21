sum_windows = [sum0_window; sum1_window; sum2_window; sum3_window];
pulse1_window = sum_windows(1,:);
pulse2_window = sum_windows(2,:);
pulse3_window = sum_windows(3,:);
pulse4_window = sum_windows(4,:);

p1_ch1 = pulse1_window(1)/sum(pulse1_window);
p1_ch2 = pulse1_window(2)/sum(pulse1_window);
p1_ch3 = pulse1_window(3)/sum(pulse1_window);
p1_ch4 = pulse1_window(4)/sum(pulse1_window);
pulse1_percentages = [p1_ch1, p1_ch2, p1_ch3, p1_ch4];
%sum(pulse1_percentages(:))

p2_ch1 = pulse2_window(1)/sum(pulse2_window);
p2_ch2 = pulse2_window(2)/sum(pulse2_window);
p2_ch3 = pulse2_window(3)/sum(pulse2_window);
p2_ch4 = pulse2_window(4)/sum(pulse2_window);
pulse2_percentages = [p2_ch1, p2_ch2, p2_ch3, p2_ch4];
%sum(pulse2_percentages(:))

p3_ch1 = pulse3_window(1)/sum(pulse3_window);
p3_ch2 = pulse3_window(2)/sum(pulse3_window);
p3_ch3 = pulse3_window(3)/sum(pulse3_window);
p3_ch4 = pulse3_window(4)/sum(pulse3_window);
pulse3_percentages = [p3_ch1, p3_ch2, p3_ch3, p3_ch4];
%sum(pulse3_percentages(:))

p4_ch1 = pulse4_window(1)/sum(pulse4_window);
p4_ch2 = pulse4_window(2)/sum(pulse4_window);
p4_ch3 = pulse4_window(3)/sum(pulse4_window);
p4_ch4 = pulse4_window(4)/sum(pulse4_window);
pulse4_percentages = [p4_ch1, p4_ch2, p4_ch3, p4_ch4];
%sum(pulse4_percentages(:))

pulse_percentages = [pulse1_percentages; pulse2_percentages;...
    pulse3_percentages; pulse4_percentages];
%figure; bar(pulse_percentages)

pulse1_ideal = [0, 0.25, 0.50, 0.25];
pulse2_ideal = [0.125, 0.125, 0.25, 0.50];
pulse3_ideal = [0.25, 0, 0.50, 0.25];
pulse4_ideal = [0.125, 0.125, 0.50, 0.25];
ideal_pulses = [pulse1_ideal; pulse2_ideal; pulse3_ideal; pulse4_ideal];
figure; bar(ideal_pulses); axis([0, 5, 0, 1]);

a = (ideal_pulses(1,:) - pulse_percentages(1,:))*100;
b = (ideal_pulses(2,:) - pulse_percentages(2,:))*100;
c = (ideal_pulses(3,:) - pulse_percentages(3,:))*100;
d = (ideal_pulses(4,:) - pulse_percentages(4,:))*100;

ratio = [a;b;c;d];
%figure; bar(ratio)