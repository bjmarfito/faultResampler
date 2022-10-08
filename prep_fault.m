function [] = prepFault(strike, dip, rake, len, wid, top_depth, vertices)

%% Code to generate fault model based on unfirom elastic dislocation model
% All units must be in meters
% Right-hand rule is the convention for strike, dip, and rake measurements
% Vertices should be in UTM coordinates, If the fault is due north the first point is located south of the second point
% Output filename is faultmodel.m
%% Author: Bryan Marfito

faultstruct = [];
faultstruct.strike = strike;
faultstruct.dip = dip;
faultstruct.rake = rake;
faultstruct.W = wid;
faultstruct.L = len;
faultstruct.zt = top_depth;
faultstruct.vertices = vertices;

save faultstruct faultmodel