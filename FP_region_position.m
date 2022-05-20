% draws the scanned regions for two polarizations in the FP
% use to determine the possible locations
% based just on geometry (no PR evaluation involved)

clear; %close all

npix = 560;         % number of DMD pixels
a = 13.48;          % pixel size (um)

BD = 4*10^3;        % beam displacement (um)
F1 = 300*10^3;      % lens 1 focal length (um)
lambda = 0.473;     % um

FOV = 170;          % no modes scanned (side of the square scanned in the FP)

CenterX = 180;      % position of the central frequency in the FP
CenterY = 95;

%% distance of central frequencies in the FP (pix)

FP_pixel = F1*lambda/(npix*a);  % pixel size in the FP
displ_dist = round(BD/FP_pixel);

%% START CALCULATIONS

angles = linspace(0, 2*pi, 500);
x_space = linspace(-npix/2,npix/2);

x = displ_dist * cos(angles) + CenterX;
y = displ_dist * sin(angles) + CenterY;

figure
plot(x, y, 'b-', 'LineWidth', 1); axis image; hold on
% scanned region around first central frequency
rectangle('Position',[CenterX-FOV/2 CenterY-FOV/2 FOV FOV],'EdgeColor','b')
plot(CenterX, CenterY, 'b+', 'LineWidth', 1, 'MarkerSize', 14);

% scanned regions around second central frequency at distance
for i = 5:15:size(x,2)
    rectangle('Position',[x(i)-FOV/2 y(i)-FOV/2 FOV FOV],'EdgeColor','r')
end

% move origin to the centre
xlim([-npix/2 npix/2])
ylim([-npix/2 npix/2]) 
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
   
% draw diagonals
plot(x_space, x_space,'k:');
plot(-x_space, x_space,'k:');

title([num2str(lambda) ' nm, F1 = ' num2str(F1/1000) ' mm, npix = ' num2str(npix) ', FOV = ' num2str(FOV)])

