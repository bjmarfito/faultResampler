%%%%% LOADRESAMPDATA.M %%%%%%
%
%
%   Updated January 28, 2015, by WDB
%   University of Iowa
%
%%%% This file will load both resampled InSAR data and GPS data.  All data and covariance values must be scaled to meters
%%%% The .mat files loaded as datafiles must contain a structure that
%%%% contains a variable called 'savestruct'.  'Savestruct' should have the
%%%% following format:
%
%         savestruct= 
%             
%             data: [1xnp struct]
%             np: np
%             covstruct: [1x1 struct]
%             zone: 'UTM ZONE'
%
%
%               savestruct.data=
%                     1xnp strctural array
%                       x
%                       y
%                       scale
%                       count
%                       X
%                       Y
%                       data
%                       S
%                       boxx
%                       boxy
%%%%%% In order to run this code, only X, Y, data, and S must be defined by
%%%%%% real values.  When loading GPS, the other fields may be filled with
%%%%%% zeros as dumby variables.  'S' must be [3 x np], 'boxx' and 'boxy' must be
%%%%%% [5 x np].  The code RESAMPTOOL.M will automatically put InSAR data
%%%%%% into this format.  MAKEGPSCORRECT.M will put GPS data into the
%%%%%% correct structure.  X and Y must be in UTM coordinates.

global rampg Cdinv nramp rake covd2 smooth_method reg_method rake_type data_type faultstruct


%%% Define datafiles to be used from a .mat format.  Follow the directions
%%% from above in order to have datafiles in the correct format for
%%% loading.


datafiles           = {'dataDemo.mat'};
faultfiles          = {'faultDemo.mat'};   % Fault to be resampled
rake_type           = 'fixed';                % free or fixed.  Rake must be defined below if rake_type=free
smooth_method       = 'mm';          % laplacian or mm (minimum moment)
reg_method          = 'jRi';  % jRi or lcurve
data_type           = 'InSAR';
rake                = 178;
flag                = 1;  % Plotting flag: 1= plots after each iteration, 0= plots only at end

np                  = 0;
resampstruct        = [];
covd                = [];
rampg               = [];

%%% Loads information from multiple data sources.  Can load InSAR and GPS
%%% simultaneously

for i=1:length(datafiles)
    load(datafiles{i})
    allnp(i)        = savestruct.np;
    resampstruct    = [resampstruct savestruct.data];
    tmpcov          = savestruct.covstruct.cov;
    covd            = blkdiag(covd, tmpcov);
end

data = [resampstruct.data]';
np      = sum(allnp);               %Total number of data points

X       = [resampstruct.X]';        % Easting coordinates
Y       = [resampstruct.Y]';        % Northing coordinates
boxx    = [resampstruct.trix];      % Resampled triangles for InSAR data
boxy    = [resampstruct.triy];
S       = [resampstruct.S];         % Look direction
ch      = chol(covd);               % For scaling data
Cdinv   = inv(ch');                 
sortt   = 0;
EQt     = 0;
Dnoise  = Cdinv*data;         % Weighted Data

% Make ramp
for i=1:length(datafiles)
    id    = [1:allnp(i)]+sum(allnp(1:(i-1)));
    Xtmp  = (X(id)-min(X(:)))/1e4;
    Ytmp  = (Y(id)-min(Y(:)))/1e4;
    XXtmp = Xtmp.^2;
    YYtmp = Ytmp.^2;
    XYtmp = Xtmp.*Ytmp;
    XXtmp = XXtmp/max(XXtmp);
    YYtmp = YYtmp/max(YYtmp);
    XYtmp = XYtmp/max(XYtmp);
    %% Comment and uncomment the different options below based on the shape of ramps to be inverted for
    %rampg = []; % No ramp
    %rampg = [rampg; [Xtmp';Ytmp';ones(1,allnp(i))]); %Linear ramp
    rampg  = blkdiag(rampg,[Xtmp'; Ytmp'; ones(1,allnp(i));XYtmp';XXtmp';YYtmp']); % Bilinear ramp
    %rampg   = blkdiag(rampg, [Xtmp'; Ytmp'; ones(1,allnp(i)); %Xtmp'.*Ytmp'; Xtmp'.^2.*Ytmp'.^2]); %Quadratic ramp
end

nramp   =size(rampg,1);

% Load Fault Paramters
load(faultfiles{1})

strike   = [faultstruct.strike];
dip      = [faultstruct.dip];
L        = [faultstruct.L];
W        = [faultstruct.W];
zt       = [faultstruct.zt];
vertices = [faultstruct.vertices];

if dip==90
    dip = 89.9;
end

if strike<0
    strike= strike + 360;
end


% Conventions for Meade Code.  

clear resampstruct
[resampstruct.data]= data;
[resampstruct.X]= X;
[resampstruct.Y]= Y;
[resampstruct.boxx]= boxx;
[resampstruct.boxy]= boxy;
[resampstruct.S]= S;


resampOptions


%%%% Uncomment the following lines to plot the demo slip and data distributions

%     figure
%     subplot(1,2,1)
%     patch([savestruct.demo.patchstruct.yfault], [savestruct.demo.patchstruct.zfault], [savestruct.demo.slip])
%     yrev
%     axis image
%     colorbar
%     title('Input Slip Model')
%
%     subplot(1,2,2)
%     scatter(X,Y,24,data,'filled')
%     axis image
%     colorbar
%     hold on
%     plot(vertices(1,:), vertices(2,:))
%     title('Starting Noisy Data')








