close all;
clear all;

%Inputs
t_start = 200; %spin up period (days), recommended to run at least one year
site = 1; %Specify EcH2O-iso output cell
Tree_V = 100; %tree volume (mm)

%Read in RWU d18O
%Assumes EcH2O-iso output file format, excluding the header
infile = 'E:\Ecohydrology_Review\Outputs\d18OevapT_0.tab';
d18O = dlmread(infile);

%Read in RWU d2H
%Assumes EcH2O-iso output file format, excluding the header
infile = 'E:\Ecohydrology_Review\Outputs\d2HevapT_0.tab';
d2H = dlmread(infile);

%Replace EcH2O-iso place holder values (i.e. -1000) with previous d value
for i = 2:length(d18O(:,1))
    if d18O(i,site+1) == -1000
        d18O(i,site+1) = d18O(i-1,site+1);
    end
    if d2H(i,site+1) == -1000
        d2H(i,site+1) = d2H(i-1,site+1);
    end
end


%Read in RWU
%Assumes EcH2O-iso output file format, excluding the header
infile = 'E:\Ecohydrology_Review\Outputs\EvapT_0.tab';
T = dlmread(infile);
T(:,2:9) = T(:,2:9)*1000*86400; %Convert from m3/s to mm / (100 m^2 * day) where 100^2 m is the horizontal grid size

%Specify initial conditions
%Requires running at least 1 year spin up to compute backward cummulative
%RWU volume
Tree_Isotope = zeros(length(T(:,1)),5);

%Compute tree water isotopic composition
for i = t_start:length(T(:,1))

    Tree_Isotope(i,1) = i;
    
    %Compute backwards cummulative RWU volume
    T_Cumm = cumsum(T(1:i,site+1),'reverse');
    T_Cumm = sortrows(T_Cumm,1);
    
    %Find index of RWU ~ Tree_V
    [minValue,Index] = min(abs(T_Cumm - Tree_V));
    
    %Find midpoint of Tree_V
    [minValue,Index_mid] = min(abs(T_Cumm - Tree_V/2));

    %d18O
    %Average tree isotopic composition under PF
    Tree_Isotope(i,2) = sum(d18O(i-Index:i,site+1).*T(i-Index:i,site+1))/Tree_V;
    %midpoint tree isotopic composition under PF
    Tree_Isotope(i,3) = d18O(i-Index_mid,site+1);

	%d2H
    %Average tree isotopic composition under PF
    Tree_Isotope(i,4) = sum(d2H(i-Index:i,site+1).*T(i-Index:i,site+1))/Tree_V;
    %midpoint tree isotopic composition under PF
    Tree_Isotope(i,5) = d2H(i-Index_mid,site+1);
    
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
plot(Tree_Isotope(:,2),'color',[0 0 1]);
plot(Tree_Isotope(:,3),'color',[0 1 0]);

ylim([-30 0]);
ylabel('\delta^1^8O (‰)');
legend('\delta_R_W_U','\delta_T_r_e_e','\delta_T_r_e_e Mid','location','southeast');

subplot(3,1,3)
plot(d2H(:,site+1),'color',[1 0 0]);
hold on;
plot(Tree_Isotope(:,4),'color',[0 0 1]);
plot(Tree_Isotope(:,5),'color',[0 1 0]);
ylim([-150 0]);
ylabel('\delta^2H (‰)');
