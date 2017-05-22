e = 0.5 - sqrt((1-D)*D);
de = 0.5 - sqrt(e*(1-e));

e1 = 0.5 - sqrt((1-0.1)*0.1);
e2 = 0.5 - sqrt((1-0.1)*0.2);
e3 = 0.5 - sqrt((1-0.1)*0.3);
e4 = 0.5 - sqrt((1-0.1)*0.4);
e5 = 0.5 - sqrt((1-0.1)*0.5);
e6 = 0.5 - sqrt((1-0.1)*0.1);
e7 = 0.5 - sqrt((1-0.1)*0.2);
e8 = 0.5 - sqrt((1-0.1)*0.3);
e9 = 0.5 - sqrt((1-0.1)*0.4);
e10 = 0.5 - sqrt((1-0.1)*0.5);
e=[e1,e2,e3,e4,e5,e6,e7,e8,e9,e10];

de1 = 0.5 - sqrt(e1*(1-e1));
de2 = 0.5 - sqrt(e2*(1-e2));
de3 = 0.5 - sqrt(e3*(1-e3));
de4 = 0.5 - sqrt(e4*(1-e4));
de5 = 0.5 - sqrt(e5*(1-e5));
de6 = 0.5 - sqrt(e6*(1-e6));
de7 = 0.5 - sqrt(e7*(1-e7));
de8 = 0.5 - sqrt(e8*(1-e8));
de9 = 0.5 - sqrt(e9*(1-e9));
de10 = 0.5 - sqrt(e10*(1-e10));
de=[de1,de2,de3,de4,de5,de6,de7,de8,de9,de10];

figure;
plot(de, e, 'b--')