function [] = prep_fault(strike, dip, rake, len, wid, top_depth, vertices)

%% Code to generate a fault model based on uniform elastic dislocation model
%
% Important Notes:
% 1. All units must be in degrees or meters 
% 2. Right-hand rule is the convention for strike, dip, and rake measurements.
% 3. Vertices should be a (2x2) matrix with the first row containing the x-coordinates (longitude), and the second row containing the y-coordinates (latitude).
% 4. Vertices should be in UTM coordinates. If the fault is due north, the first point is located south of the second point.
% 5. Output filename is faultmodel.m
%
%% Author: Bryan Marfito

faultstruct.strike = strike;
faultstruct.dip = dip;
faultstruct.rake = rake;
faultstruct.W = wid;
faultstruct.L = len;
faultstruct.zt = top_depth;
faultstruct.vertices = vertices;

save faultmodel faultstruct
