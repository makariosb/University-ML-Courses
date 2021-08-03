%%
clc; clear; close all;

[x, c] = ReadGlass(214);
[Rc1, Ru1, Rep, Mean1] = ClassMinDistEuclOne(x, c);
Mean1 %ta varykentra (ideata dianysmata)
Cerrors1 = Rep - Rc1;
Uerrors1 = Rep - Ru1;
%Percent errors
Cpercent1 = sum(Cerrors1) / sum(Rep)
Upercent1 = sum(Uerrors1) / sum(Rep)
save('kentra.mat')
%%
clc; clear; close all;
load('kentra.mat');

Mean2 = ProtypoDianysma(x, c);
Mean1
Mean2 %Protypa Paradeigmata Klasewn

MeanError = (Mean2 - Mean1) %Apoklisi apo ta ideata dianysmata

[Rc2, Ru2] = Errors(Mean2, x, c);

Cerrors2 = Rep - Rc2
Uerrors2 = Rep - Ru2

Cpercent2 = sum(Cerrors2) / sum(Rep)
Upercent2 = sum(Uerrors2) / sum(Rep)

Cerrors = [Cerrors1 Cerrors2];
Uerrors = [Uerrors1 Uerrors2];

percent = [sum(Cerrors1) sum(Uerrors1); sum(Cerrors2) sum(Uerrors2)] / 214
