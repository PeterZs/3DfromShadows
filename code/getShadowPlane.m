function [shadowPlanePts] = getShadowPlane(edgeLine2d, lightLoc, cameraParams)
% Calculates the shadow plane by finding 2 3d points on the intersection of 
% shadow plane and horizontal plane.
% Input:
%  edgeLine2d: 4xn matrix where n is the number of frames from the scan;
%              each column is [x1 y1 x2 y2]' that specifies 2 points on the
%              2d line
%  cameraLoc: 3x1 vector specifying the location of light source
%  cameraParams: a camera parameter structure
% Output:
%  shadowPlanePts: 9xn matrix where n is the number of frames from the
%                  scan; each column is [x1 y1 z1 x2 y2 z2 lx ly lz] that 
%                  specifies 3 points on the shadow plane

N = size(edgeLine2d,2);
pts3d = pointsToWorld(cameraParams, mean(cameraParams.RotationMatrices,3),...
   mean(cameraParams.TranslationVectors,1), reshape(edgeLine2d,2,[])');
shadowPlanePts = zero(9,N);
shadowPlanePts(1:2,:) = pts3d(1:2:2*N, :)';
shadowPlanePts(4:5,:) = pts3d(2:2:2*N, :)';
shadowPlanePts(7:9,:) = repmat(lightLoc,1,N);

end