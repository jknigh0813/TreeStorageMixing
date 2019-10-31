close all;
clear all;

%Inputs
site = 1; %Specify EcH2O-iso output cell
Tree_V = 50; %tree volume (mm)

%Read in RWU d18O
%Assumes EcH2O-iso output file format, excluding the header
infile = 'E:\Ecohydrology_Review\Outputs\d18OevapT_0.tab';
d18O = dlmread(infile);

%Read in RWU d2H
%Assumes EcH2O-iso output file format, excluding the header
infile = 'E:\Ecohydrology_Review\Outputs\d2HevapT_0.tab';
d2H = dlmread(infile);

%Read in RWU
%Assumes EcH2O-iso output file format, excluding the header
infile = 'E:\Ecohydrology_Review\Outputs\EvapT_0.tab';
T = dlmread(infile);
T(:,2:9) = T(:,2:9)*1000*86400; %Convert from m3/s to mm / (100 m^2 * day) where 100^2 m is the horizontal grid size

%Specify initial conditions
%Recommend running at least 1 year spin up to eliminate the effects of
%initial conditions
Tree_Isotope = zeros(length(T(:,1)),3);
Tree_Isotope(1,1) = 1; %time step
Tree_Isotope(1,2) = -10; %d18O
Tree_Isotope(1,3) = -50; %d2H

%Compute tree water isotopic composition
for i = 2:length(T(:,1))

    Tree_Isotope(i,1) = i;
    Tree_Isotope(i,2) = (Tree_V*Tree_Isotope(i-1,2) + T(i,site+1)*d18O(i,site+1) - T(i,site+1)*Tree_Isotope(i-1,2))/Tree_V;
    Tree_Isotope(i,3) = (Tree_V*Tree_Isotope(i-1,3) + T(i,site+1)*d2H(i,site+1) - T(i,site+1)*Tree_Isotope(i-1,3))/Tree_V;
    
end

%Clean up for plotting
d18O(d18O == -1000) = NaN;
d2H(d2H == -1000) = NaN;

%Optional plotting
subplot(3,1,1)
plot(T(:,site+1),'color',[0 1 0]);
ylabel('RWU (mm^1day^-^1)');

subplot(3,1,2)
plot(d18O(:,site+1),'color',[1 0 0]);
hold on;
plot(Tree_Isotope(:,site+1),'color',[0 0 1]);
ylim([-30 0]);
ylabel('\delta^1^8O (‰)');
legend('\delta_R_W_U','\delta_T_r_e_e','location','southeast');

subplot(3,1,3)
plot(d2H(:,site+1),'color',[1 0 0]);
hold on;
plot(Tree_Isotope(:,3),'color',[0 0 1]);
ylim([-150 0]);
ylabel('\delta^2H (‰)');
